//
//  ArraysView.swift
//  iOSDevLearning
//
//  Created by Rabie on 07/02/2025.
//

import SwiftUI


struct UserModel:Identifiable{
    let id = UUID().uuidString
    let name:String?
    let points:Int
    let isVerified:Bool
}

@Observable
class ArrayModoficationViewModel{
    var dataArray : [UserModel] = []
    var filteredArray: [UserModel] = []
    var mappedArray : [String] = []
    
    
    
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    
    
    func getUsers(){
        let user1 = UserModel(name: "Rabie", points: 10, isVerified: true)
        let user2 = UserModel(name: "hamid", points: 12, isVerified: false)
        let user3 = UserModel(name: "salim", points: 4, isVerified: true)
        let user4 = UserModel(name: "marco", points: 8, isVerified: true)
        let user5 = UserModel(name: "adam", points: 0, isVerified: false)
        let user6 = UserModel(name: nil, points: 15, isVerified: false)
        let user7 = UserModel(name: "bilel", points: 6, isVerified: false)
        let user8 = UserModel(name: nil, points: 3, isVerified: true)
        let user9 = UserModel(name: "mouhaned", points: 43, isVerified: true)
        let user10 = UserModel(name: "mohamed", points: 1, isVerified: true)
        let user11 = UserModel(name: nil, points: 22, isVerified: false)
        
        dataArray.append(contentsOf: [user1,
                                      user2,
                                      user3,
                                      user4,
                                      user5,
                                      user6,
                                      user7,
                                      user8,
                                      user9,
                                      user10,
                                      user11
                                     ])
    }
    
    func updateFilteredArray(){
        

        //sort:
        
     /*
      
      
//        filteredArray = dataArray.sorted { user1, user2 in
//            return user1.points > user2.points
//        }
      
        
        
        filteredArray = dataArray.sorted(by:{$0.points > $1.points})
      
      */

//-----------------------------------------------------
        
        //filter:
        
       /* filteredArray = dataArray.filter({ $0.isVerified}) */
        
        
//------------------------------------------------------
        
        
        //map:
 /*
        
//        mappedArray = dataArray.map({ user in
//            return  user.name
//        })
//
        
        
        //compact map:
        //return only not null data : ignore it
        mappedArray = dataArray.compactMap({$0.name})
  */
        
//------------------------------------------------------
        
        // all :
        
      //  let sort = dataArray.sorted(by: { $0.points > $1.points })
      //  let filter = dataArray.filter({$0.isVerified})
     //let map = dataArray.compactMap({$0.name})
        mappedArray = dataArray
            .sorted(by: { $0.points > $1.points })
            .filter({$0.isVerified})
            .compactMap({$0.name})
        
        
    }
}


struct ArraysView: View {
    @State var vm = ArrayModoficationViewModel()
    var body: some View {
        ScrollView{
            VStack(spacing:10){
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
                
                
//                ForEach(vm.filteredArray){user in
//                    VStack(alignment:.leading){
//                        Text(user.name)
//                            .font(.headline)
//                        HStack{
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                    
//                }
                
                
            }
        }
    }
}

#Preview {
    ArraysView()
}
