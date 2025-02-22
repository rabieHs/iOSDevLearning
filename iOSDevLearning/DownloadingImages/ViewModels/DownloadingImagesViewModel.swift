//
//  DownloadingImagesViewModel.swift
//  iOSDevLearning
//
//  Created by Rabie on 22/02/2025.
//

import Foundation
import Combine

class DownloadingImagesViewModel:ObservableObject{
    @Published var dataArray : [PhotoModel] = []
    let dataService = PhotoModelDataService.instance
    var cancellables = Set<AnyCancellable>()

    
    init() {
        addSubscribers()
    }
    
    func addSubscribers(){
        dataService.$photoModel.sink { [weak self] returnedPhotoModels in
            self?.dataArray = returnedPhotoModels
        }
        .store(in: &cancellables)
    }
}
