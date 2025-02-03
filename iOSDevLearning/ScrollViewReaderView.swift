//
//  ScrollViewReaderView.swift
//  iOSDevLearning
//
//  Created by Apple on 03/02/2025.
//

import SwiftUI

struct ScrollViewReaderView: View {
    @State var textFieldText:String = ""
    @State var scrollToIndex : Int = 0
    var body: some View {
        VStack {
            TextField("enter number here", text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 55)
                .border(.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            Button("Scroll Now") {
                withAnimation(.spring){
                    if let index = Int(textFieldText){
                        scrollToIndex = index
                    }
                    //proxy.scrollTo(49, anchor: .bottom)
                }
            }
            ScrollView{
                ScrollViewReader { proxy in
              
                    ForEach(0..<50,id: \.self) { index in
                        Text("This item is #\(index)")
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                        
                    }
                    .onChange(of: scrollToIndex, initial: true) { oldValue, newValue in
                        withAnimation(.spring) {
                            proxy.scrollTo(newValue,anchor: .bottom)
                        }
                    }
                }
                
            }
        }
    }
}

#Preview {
    ScrollViewReaderView()
}
