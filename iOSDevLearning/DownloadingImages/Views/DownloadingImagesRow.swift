//
//  DownloadingImagesRow.swift
//  iOSDevLearning
//
//  Created by Rabie on 22/02/2025.
//

import SwiftUI

struct DownloadingImagesRow: View {
    let model:PhotoModel
    var body: some View {
        HStack{
            ImageView(url: model.url,key: "\(model.id)")
                .frame(width: 75, height: 75)
            VStack(alignment: .leading){
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .foregroundStyle(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        
            
        }

    }
}

#Preview {
    DownloadingImagesRow(model: PhotoModel(albumId: 1, id: 1, title: "title", url: "https://plus.unsplash.com/premium_photo-1690406382383-3827c1397c48?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", thumbnailUrl: "url"))
}
