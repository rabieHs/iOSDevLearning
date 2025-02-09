//
//  BackgroundThreadView.swift
//  iOSDevLearning
//
//  Created by Rabie on 09/02/2025.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject{
    @Published var dataArray:[String] = []
    
    func fetchData(){
        DispatchQueue.global(qos: .background).async {
            print(Thread.isMainThread)
            print(Thread.current)
            let newData = self.downloadData()
            DispatchQueue.main.async {
                self.dataArray = newData
            }
        }
    }
    
   private func downloadData()->[String]{
        var data:[String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
    
}

struct BackgroundThreadView: View {
    @StateObject var vm = BackgroundThreadViewModel()
    var body: some View {
        ScrollView{
            VStack(spacing:10){
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    BackgroundThreadView()
}
