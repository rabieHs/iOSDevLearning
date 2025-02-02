//
//  LongPressGesture.swift
//  iOSDevLearning
//
//  Created by Apple on 02/02/2025.
//

import SwiftUI

struct LongPressGesture: View {
    @State private var isComplete:Bool = false
    @State private var isSuccess:Bool = false
    var body: some View {
        
        VStack{
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(Color.gray)
            
            
            HStack{
                
                Text("Click Here")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1, maximumDistance: 50,pressing: { isPressing in
                        //start of press -> min duration
                        if isPressing{
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isComplete = true}
                            }else{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    if !isSuccess {
                                        withAnimation(.easeInOut) {
                                            isComplete = false
                                        }
                                    }
                                }
                            
                        }
                    },perform: {
                        //at the min duration
                        
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                     
                    })
                
                
                
                Text("Reset")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
            
       
            

               
                
        }
        
        
        
        
        
        
        
        
        
//        Text(isComplete ? "COMPLETED": "NOT COMPLETED")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color.green : Color.gray)
//            .cornerRadius(10)
//            .onLongPressGesture(minimumDuration:1.0,maximumDistance:50) {
//                isComplete.toggle()
//            }
    }
}

#Preview {
    LongPressGesture()
}
