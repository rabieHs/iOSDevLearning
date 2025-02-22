//
//  DownloadingImageView.swift
//  iOSDevLearning
//
//  Created by Rabie on 22/02/2025.
//

import SwiftUI


struct ImageView: View {
    @StateObject var vm :ImageLoadingViewModel
    
    init(url:String,key:String) {
        _vm = StateObject(wrappedValue: ImageLoadingViewModel(url: url,key: key))
    }
    var body: some View {
        ZStack{
            if vm.isLoading {
                ProgressView()
            }else if let image = vm.image{
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
                
            }
        }
    }
}

#Preview {
    ImageView(url: "https://plus.unsplash.com/premium_photo-1690406382383-3827c1397c48?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",key: "ph")
}
