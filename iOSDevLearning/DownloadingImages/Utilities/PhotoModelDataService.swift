//
//  PhotoModelDataService.swift
//  iOSDevLearning
//
//  Created by Rabie on 22/02/2025.
//

import Foundation
import Combine

class PhotoModelDataService{
    
    static let instance = PhotoModelDataService()
    
    @Published var photoModel: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    func downloadData(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {return}
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder:JSONDecoder() )
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: {[weak self]  photoList in
                self?.photoModel = photoList
            }
            .store(in: &cancellables)

    }
    
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output)throws -> Data{
        guard let response = output.response as? HTTPURLResponse ,
              response.statusCode >= 200 && response.statusCode < 300
        else{
            throw URLError(.badServerResponse)
        }
        return output.data
                
    }
    
    private init(){
        downloadData()
    }
}
