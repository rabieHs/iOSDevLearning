//
//  PhotoModelCacheManager.swift
//  iOSDevLearning
//
//  Created by Rabie on 22/02/2025.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager{
    static let instance = PhotoModelCacheManager()
    
    private init(){}
    
    var photoCache:NSCache<NSString,UIImage> = {
        let cache = NSCache<NSString,UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200
        return cache
    }()
    
    func add(key:String,value:UIImage){
        print("adding image to cache")
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key:String)->UIImage?{
        print("getting cache Image")
        do {
                 return photoCache.object(forKey: key as NSString)
        } catch  {
            print("error getting cache image \(error.localizedDescription)")
        }
    }
}
