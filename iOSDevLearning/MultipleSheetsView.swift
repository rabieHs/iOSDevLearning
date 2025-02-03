//
//  MultipleSheetsView.swift
//  iOSDevLearning
//
//  Created by Apple on 03/02/2025.
//

import SwiftUI


struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title : String
    
}

// 1- use binding
// 2- use multiple sheets
// 3- use items

struct MultipleSheetsView: View {
  //  @State var selectedModel : RandomModel = RandomModel(title: "Starting title")
    @State var selectedModel : RandomModel? = nil
    @State var showSheet:Bool = false
   // @State var showSheet2:Bool = false
  
    var body: some View {
        VStack(spacing:20){
            Button("button 1") {
                selectedModel = RandomModel(title: "One")
                //showSheet.toggle()
            }
//            .sheet(isPresented: $showSheet) {
//                NextScreen(selectedModel: RandomModel(title: "One"))

//            }
            Button("button 2") {
                selectedModel = RandomModel(title: "Two")
               // showSheet2.toggle()


            }
//            .sheet(isPresented: $showSheet2) {
//                NextScreen(selectedModel: RandomModel(title: "Two"))
//
//            }
        }
        
        .sheet(item: $selectedModel) { model in
            NextScreen(selectedModel: model)
        }
//        .sheet(isPresented: $showSheet) {
//            NextScreen(selectedModel: selectedModel)
//        }
     
    }
}

struct NextScreen:View {
   // @Binding var selectedModel: RandomModel
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsView()
}
