//
//  DownloadDataWithEscaping.swift
//  iOSDevLearning
//
//  Created by Rabie on 13/02/2025.
//

import SwiftUI




struct PostModel:Identifiable,Codable {
    let id:Int
    let userId:Int
    let title:String
    let body:String
}

class DownloadWithEcapingViewModel:ObservableObject{
    @Published var posts : [PostModel] = []
    
    
    init() {
        getPosts()
    }
    func getPosts(){
        
       
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
            downloadData(fromURL: url) { data in
            if let data {
                guard   let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else{
                    return
                }
                
                DispatchQueue.main.async {[weak self] in
                    self?.posts = newPosts

                }

            }else{
                print("No Data Returned")
                return
            }

        }
        
     
    }
    
    func downloadData(fromURL url:URL, completion:@escaping((Data?)->())){
        
        // data task automatically run on background thread
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200  && response.statusCode < 300
            else
            {
                print("error")
                completion(nil)
                return
            }
            
            completion(data)
            
            
                
        }.resume()
    }
}

typealias DataResult = (Data?)->()

struct DownloadDataWithEscapingView: View {
    @StateObject var vm = DownloadWithEcapingViewModel()
    var body: some View {
        List{
            ForEach(vm.posts){post in
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
    DownloadDataWithEscapingView()
}
