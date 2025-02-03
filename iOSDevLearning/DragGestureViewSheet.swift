//
//  DragGestureViewSheet.swift
//  iOSDevLearning
//
//  Created by Apple on 03/02/2025.
//

import SwiftUI

struct DragGestureViewSheet: View {
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.83
    @State var currentDargOffsetY : CGFloat = 0
    @State var endingOffsetY : CGFloat = 0
    var body: some View {
        ZStack{
            Color.green.ignoresSafeArea()
            
            SignUpSubView()
                .offset(y:startingOffsetY)
                .offset(y:currentDargOffsetY)
                .offset(y:endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.spring) {
                                currentDargOffsetY = value.translation.height
                                

                            }
                        }
                        .onEnded{ value in
                            withAnimation(.spring){
                                if currentDargOffsetY < -150 {
                                    endingOffsetY =  -startingOffsetY
                                }
                                else if endingOffsetY != 0 && currentDargOffsetY > 150{
                                    endingOffsetY = 0
                                }
                                    currentDargOffsetY = 0
                                
                            }
                        }
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    DragGestureViewSheet()
}

struct SignUpSubView: View {
    var body: some View {
        VStack(spacing:20){
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100,height: 100)
            Text("This is the Description for our app, this is my vafourite SwiftUI and I recommend to all of my firends to follow this course!")
                .multilineTextAlignment(.center)
            Text("CREATE AN ACCOUNT")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal)
                .padding()
                .background(.black)
                .cornerRadius(10)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}
