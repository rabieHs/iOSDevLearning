//
//  MagnificationGesture.swift
//  iOSDevLearning
//
//  Created by Apple on 02/02/2025.
//

import SwiftUI

struct MagnificationGestureView: View {
    @State var currentAmoumt: CGFloat = 0
    @State  var lastAmount :CGFloat = 0
    var body: some View {
        
        
        
        
        VStack(spacing:10){
            HStack{
                Circle()
                    .frame(width: 35,height: 35)
                Text("Rabie houssaini")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Image("image")
                .resizable()
  
                .frame(height: 300)
                .scaleEffect(1 + currentAmoumt)
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                            currentAmoumt = value - 1
                        }
                        .onEnded{ value in
                            withAnimation(.spring) {
                                currentAmoumt = 0
                            }
                        }
                        
                
                )
            HStack{
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            
            Text("a mock version of a social media post")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
        }
        
        
        
        
        
        
        
        
        
        
//        Text("Hello, World!")
//            .font(.title)
//            .padding()
//            .background(Color.red)
//            .cornerRadius(10)
//            .scaleEffect(1 + currentAmoumt + lastAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged{ value in
//                        
//                        currentAmoumt = value - 1
//                    }
//                    .onEnded{ _ in
//                        // we can remove it from ios 17 it fixed withoud last amount
//                        lastAmount += currentAmoumt
//                        currentAmoumt = 0
//                    }
//                    
//            
//            )
    }
}

#Preview {
    MagnificationGestureView()
}
