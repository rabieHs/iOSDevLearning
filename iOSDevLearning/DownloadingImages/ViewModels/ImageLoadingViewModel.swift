//
//  ImageLoadingViewModel.swift
//  iOSDevLearning
//
//  Created by Rabie on 22/02/2025.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel : ObservableObject{
    @Published var image:UIImage? = nil
    @Published var isLoading:Bool = false
    let urlString:String
    
    var cancellables = Set<AnyCancellable>()
    
    let manager = PhotoModelCacheManager.instance
    let imageKey:String
    
    
    init(url:String,key:String) {
        urlString = url
        imageKey = key
        
        getImage()
    }
    
    func getImage(){
      
        
        
        if let savedImage =    manager.get(key: imageKey) {
            image = savedImage
            print("getting saved images")
        }else{
            downloadImage()
        }
    }
    
    func downloadImage(){
        print("downloading image now")
        isLoading = true
        guard let url = URL(string: urlString) else{
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
//            .map { data, response in
//                return UIImage(data: data)
//            }
            .map({UIImage(data: $0.data)})
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard let self = self,
                      let image = returnedImage
                else{return}
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)

    }
    
}
