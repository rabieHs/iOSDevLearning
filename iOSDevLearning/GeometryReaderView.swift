//
//  GeometryReaderView.swift
//  iOSDevLearning
//
//  Created by Apple on 03/02/2025.
//

import SwiftUI

struct GeometryReaderView: View {
    
    
    func getPercentage(geo:GeometryProxy)-> Double{
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    var body: some View {

        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(Angle(degrees: getPercentage(geo: geometry) * 40), axis: (x: 0, y: 1, z: 0))
                       
                    }
                    .frame(width: 300,height: 250)
                    .padding()
               
                }
            }
        }
        
        
        
//        GeometryReader { proxy in
//            HStack(spacing:0){
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: proxy.size.width * 0.666)
//                Rectangle()
//                    .fill(Color.blue)
//            }
//            .ignoresSafeArea()
//        }
      
        
    }
}

#Preview {
    GeometryReaderView()
}
