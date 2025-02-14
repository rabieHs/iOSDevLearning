//
//  EscapingView.swift
//  iOSDevLearning
//
//  Created by Rabie on 10/02/2025.
//

import SwiftUI

class EscapingViewModel:ObservableObject{
    @Published var text = "hello"
    
    func getData(){
//        let newData = downloadData()
//        text = newData
        
        downloadData5 { [weak self] result in
            self?.text = result.data
        }
    }
    
    func downloadData()->String{
        return "NEW DATA !"
    }
    
    func downloadData2(completion:(_ data: String)->Void){
       
            completion("new data 2")
        
    }
    
    func downloadData3(completion:@escaping(_ data: String)->()){
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            completion("new data 2")
        }
        
    }
    
    func downloadData4(completion:@escaping(DownloadResult)->()){
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            let result = DownloadResult(data: "New data result")
            completion(result)
        }
        
    }
    
    func downloadData5(completion:@escaping(DownloadComletion)){
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            let result = DownloadResult(data: "New data result")
            completion(result)
        }
        
    }
    
  
}

typealias DownloadComletion = (DownloadResult)->()


struct DownloadResult{
    let data:String
}

struct EscapingView: View {
    @StateObject var vm = EscapingViewModel()
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingView()
}
