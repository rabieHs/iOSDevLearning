//
//  TypealiasView.swift
//  iOSDevLearning
//
//  Created by Rabie on 10/02/2025.
//

import SwiftUI

struct MovieModel{
    let title:String
    let director:String
    let count: Int
}

//struct TVModel{
//    let title:String
//    let director:String
//    let count: Int
//}

typealias TVModel = MovieModel

struct TypealiasView: View {
    //@State var item : MovieModel = MovieModel(title: "Title", director: "Rabie", count: 5)
    @State var item : TVModel = TVModel(title: "TVTitle", director: "RabieTV", count: 50)
    var body: some View {
        VStack{
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    TypealiasView()
}
