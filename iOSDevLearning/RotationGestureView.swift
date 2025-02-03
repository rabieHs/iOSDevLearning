//
//  RotationGestureView.swift
//  iOSDevLearning
//
//  Created by Apple on 02/02/2025.
//

import SwiftUI

struct RotationGestureView: View {
    @State var angle: Angle = Angle(degrees: 0)

    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(50)
            .background(.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
            .rotationEffect(angle)
            .gesture(
                
                RotationGesture()
                    .onChanged{ value in
                        angle = value
                    }
                    .onEnded{ value in
                        withAnimation(.spring) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

#Preview {
    RotationGestureView()
}
