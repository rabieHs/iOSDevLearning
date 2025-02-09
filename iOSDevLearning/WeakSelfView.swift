//
//  WeakSelfView.swift
//  iOSDevLearning
//
//  Created by Rabie on 09/02/2025.
//

import SwiftUI

struct WeakSelfView: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView{
            NavigationLink("Navigate") {
                WeakSelfSecondView()
                   
            }
            .navigationTitle("Screen 1")
        }.overlay (
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            ,alignment: .topTrailing
        )
    }
}
class WeakSelfSecondScreenViewModel:ObservableObject{
    @Published var data:String? = nil
    
    init() {
        print("INITIALIZE NOW!!")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + -1, forKey: "count")
    }
    
    func getData(){
     
        // create every time when navigate to the second string a reference which will be live even the user go back because the task dont finished yet
//        DispatchQueue.main.asyncAfter(deadline: .now() + 500){
//            self.data = "NEW DATA!!!!!"
//
//        }
//        
        //solution
        DispatchQueue.main.asyncAfter(deadline: .now() + 500){[weak self] in
            self?.data = "NEW DATA!!!!!"

        }
    }
}
struct WeakSelfSecondView:View {
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    var body: some View {
        VStack{
            Text("Second View")
                .font(.largeTitle)
                .foregroundStyle(.red)
            if let data = vm.data {
                Text(data)
            }
        }
    }
}



#Preview {
    WeakSelfView()
}
