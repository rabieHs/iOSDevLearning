//
//  MaskView.swift
//  iOSDevLearning
//
//  Created by Rabie on 06/02/2025.
//

import SwiftUI

struct MaskView: View {
    @State var rating: Int = 3
    var body: some View {
        ZStack{
            startsView
                .overlay (
                
                    overlayView
                        .mask(startsView)
                )
              
            }
        
    }
    
    private var overlayView: some View {
        GeometryReader{ proxy in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .frame(width: CGFloat(rating) / 5 * proxy.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var startsView: some View {
        HStack{
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
    }
}
}

#Preview {
    MaskView()
}
