//
//  PhotoModelFileMAnager.swift
//  iOSDevLearning
//
//  Created by Rabie on 22/02/2025.
//

import Foundation
import SwiftUI
class PhotoModelFileMAnager{
    static let instance = PhotoModelFileMAnager()
    
    let folderName: String = "dowloaded_photos"
    
    private init(){
        createFolderIfneeded()
    }
    
    private  func createFolderIfneeded(){
        guard let url = getFolderPath() else{return}
        
        if !FileManager.default.fileExists(atPath: url.path()){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch  {
                print("error creating folder")
            }
        }
                
    }
    
    
    func add(key:String, value:UIImage){
     guard   let data = value.pngData(),
             let url = getImagePath(key: key)
        else {return}
        
        do {
            try data.write(to: url)
        } catch  {
            print("error saving data to file manager")
        }
    }
    
    func get(key:String)->UIImage?{
        guard let url = getImagePath(key: key),
              FileManager.default.fileExists(atPath: url.path())
                
        else {return nil}
        
        return UIImage(contentsOfFile: url.path())
        
        
    }
    
    private func getImagePath(key:String)->URL?{
        guard let folder = getFolderPath() else
        {return nil}
        return folder.appendingPathComponent("\(key).png")
    }
    
    private func getFolderPath()->URL?{
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
}
