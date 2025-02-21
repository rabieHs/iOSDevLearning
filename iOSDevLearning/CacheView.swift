//
//  CacheView.swift
//  iOSDevLearning
//
//  Created by Rabie on 21/02/2025.
//

import SwiftUI


class CacheManager{
    static let instance = CacheManager()
    // private to ensure that we can't create any other instance
    private init(){}
    
    //stored property
    var imageCache : NSCache<NSString,UIImage> = {
        let cache = NSCache<NSString,UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 //100 mb
        return cache
    }()
    
    
    func add(image:UIImage,name:String){
        imageCache.setObject(image, forKey: name as NSString)
        print("Added to cache")
    }
    
    func remove(name:String){
        imageCache.removeObject(forKey: name as NSString)
        print("Remove Success")
    }
    
    func get(name:String)->UIImage?{
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel:ObservableObject{
    @Published var startingImage:UIImage? = nil
    @Published var cachedImage:UIImage? = nil
    let imageName : String = "Thumbnail"
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder(){
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache(){
        guard let startingImage else {return}
        manager.add(image: startingImage, name: imageName)
    }
    
    func removeFromCache(){
        manager.remove(name: imageName)
    }
    
    func getFromCache(){
        if let  returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
        }
    }
    
}


struct CacheView: View {
    @StateObject var vm = CacheViewModel()
    var body: some View {
        NavigationStack{
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200,height: 200)
                        .clipped()
                        .cornerRadius(10)
                
                }
                
                HStack{
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("save to Cache")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("delete from Cache")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(.red)
                            .cornerRadius(10)
                    }
                }
                
                
                Button {
                    vm.getFromCache()
                } label: {
                    Text("get from Cache")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(.green)
                        .cornerRadius(10)
                }
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200,height: 200)
                        .clipped()
                        .cornerRadius(10)
                
                }
            
                Spacer()

                
            }
       
            .navigationTitle("File Manager")
        }
    
    }
}

#Preview {
    CacheView()
}
