//
//  DownloadDataWithCombineView.swift
//  iOSDevLearning
//
//  Created by Rabie on 14/02/2025.
//

import SwiftUI
import Combine

struct Post:Identifiable,Codable {
    let id:Int
    let userId:Int
    let title:String
    let body:String
}

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts : [Post] = []
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
            
        //create the publisher

        
        URLSession.shared.dataTaskPublisher(for: url)
        
        //subscribe the publisher on backgroun thread(by default is on background)
            .subscribe(on: DispatchQueue.global(qos: .background))
        
        //recieve on main thread
            .receive(on: DispatchQueue.main)
        //tryMap (check that the data is good)
            .tryMap(handleOutput)
         
//            .tryMap { data, response  in
//                guard
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode >= 200 && response.statusCode < 300
//                else{
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
            
        // decode (decode data into post models)
            
            .decode(type: [Post].self, decoder: JSONDecoder())
          //  .replaceError(with: [])
        
        // sink (put the item into our app)
        // if we replace the error
//            .sink(receiveValue: { posts in
//                posts = returnedPosts
//            })
        
            .sink { completion in
                print("completion: \(completion)")
                switch completion{
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: {[weak self] returnedPosts in
                self?.posts = returnedPosts
            }
        //store(cancel the subscription if needed)
            .store(in: &cancellables)

    }
    
    func handleOutput(output: Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>.Output)throws ->Data{
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300
        else{
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}


struct DownloadDataWithCombineView: View {
    @StateObject var vm = DownloadWithCombineViewModel()
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack{
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
            }
        }
        
    }
}

#Preview {
    DownloadDataWithCombineView()
}
