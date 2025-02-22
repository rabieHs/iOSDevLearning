//
//  PhotoModel.swift
//  iOSDevLearning
//
//  Created by Rabie on 22/02/2025.
//

import Foundation

struct PhotoModel : Identifiable,Codable {
    let albumId:Int
    let id:Int
    let title:String
    let url:String
    let thumbnailUrl:String
    
}
