//
//  DownloadingImagesView.swift
//  iOSDevLearning
//
//  Created by Rabie on 21/02/2025.
//

import SwiftUI

struct DownloadingImagesView: View {
    @StateObject var vm = DownloadingImagesViewModel()
    var body: some View {
        NavigationStack{
            List {
                ForEach(vm.dataArray){model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

#Preview {
    DownloadingImagesView()
}
