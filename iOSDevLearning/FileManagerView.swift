//
//  FileManagerView.swift
//  iOSDevLearning
//
//  Created by Rabie on 19/02/2025.
//

import SwiftUI


class LocalFileManager{
    static let instance = LocalFileManager()
    let folderName = "my_images"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded(){
        guard let path =
                FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path()
        else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path){
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("Success creating folder")
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func deleteFolder(){
        guard let path =
                FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path()
        else {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success creating folder")
        } catch  {
            print(error.localizedDescription)
        }
    
    }
    
    func saveImage(image: UIImage,name:String)->Bool{
        //image.jpegData(compressionQuality: 1.0)
        guard   let data =  image.pngData(),
                let path = getPathForImage(name: name)
        else {return false}
        
        //data that saved by user not recreated by app
        
        //let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        
        
        //data that can downloaded again
//        FileManager
//            .default
//            .urls(for: .cachesDirectory, in: .userDomainMask)
      
        //temporary
       // let directory3 = FileManager.default.temporaryDirectory
       
        do{
          try  data.write(to: path)
            print("success saving image")
            return true

        }catch let error{
            print(error.localizedDescription)
            return false
        }
        
    }
    
    func getImage(name:String)->UIImage?{
        guard let path = getPathForImage(name: name)?.path(),
              FileManager.default.fileExists(atPath: path)
        else {return nil}
        
        return UIImage(contentsOfFile: path)
        
        
    }
    
    func deleteImage(name:String)->Bool{
        guard let path = getPathForImage(name: name)?.path(),
              FileManager.default.fileExists(atPath: path)
        else {return  false}
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }
    
    func getPathForImage(name : String )->URL?{
        guard  let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .appendingPathComponent("\(name).png") else
        {
            return nil
        }
        return path
    }
    
    
   
    
}

struct AlertItem:Identifiable{
    let id = UUID()
    let title :String
    let body:String
}

class FileMAnagerViewModel:ObservableObject{
    @Published var image:UIImage? = nil
    @Published var infoMessage:String?
    let imageName:String = "Thumbnail"
    let manager = LocalFileManager.instance
    
    @Published var alert : AlertItem?
    
    
  
    
    func getImageFromAssetsFolder(){
        image = UIImage(named: imageName)
    }
    
    func saveImage(){
        guard let image = image else {return}
       let success = manager.saveImage(image: image, name: imageName)
        print(success)
        switch success {
        case true:
            alert = AlertItem(title: "Success Saving Image", body: "image saved suucessfully")
        case false :
            alert = AlertItem(title: "Error Saving Image", body: "image saved unsse")
        }
    }
    
    func getImageFromFileManager(){
        image = manager.getImage(name: imageName)
    }
    
    func deleteImage(){
       let success  = manager.deleteImage(name: imageName)
        
        switch success {
        case true:
            alert = AlertItem(title: "Success Deleting Image", body: "image Deleted suucessfully")
            manager.deleteFolder()
        case false :
            alert = AlertItem(title: "Error Deleting Image", body: "image deleted unsse")
        }
    }
    
    init() {
        //getImageFromAssetsFolder()
        getImageFromFileManager()
    }
}

struct FileManagerView: View {
    @StateObject var vm  = FileMAnagerViewModel()
    var body: some View {
        
        NavigationStack{
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200,height: 200)
                        .clipped()
                        .cornerRadius(10)
                
                }
                
                HStack{
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("save to FM")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("delete from FM")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(.red)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()

                
            }
            .alert(item: $vm.alert, content: { alert in
            
                Alert(
                    title: Text(alert.title),
                    message: Text(alert.body),
                    dismissButton: .default(Text("OK") )
         
                )
            })
            .navigationTitle("File Manager")
        }
    }
}

#Preview {
    FileManagerView()
}
