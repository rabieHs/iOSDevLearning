//
//  CoreDataView.swift
//  iOSDevLearning
//
//  Created by Rabie on 07/02/2025.
//

import SwiftUI
import Observation
import CoreData

class CoreDataViewModel:ObservableObject{
    let container: NSPersistentContainer
    @Published var savedEntities:[Fruite] = []
    
    init(){
        container = NSPersistentContainer(name: "FruiteContainer")
        container.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            }else{
                print("Successfully Loading core data")
            }
          
        }
        fetchFruits()
    }
    
    func fetchFruits(){
        let request = NSFetchRequest<Fruite>(entityName: "Fruite")
        do{
            savedEntities =  try  container.viewContext.fetch(request)

        }catch{
            print("Error Fetching \(error.localizedDescription )")
        }
    }
    
    func addFruite(name: String){
        let newFruite = Fruite(context: container.viewContext)
        newFruite.name = name
        saveData()

      
    }
    
    func deleteFruite(indexSet:IndexSet){
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruite(fruite:Fruite){
        let currentName = fruite.name ?? ""
        let newName = currentName + "!"
        print("new name: \(newName)")
        fruite.name = newName
        saveData()
    }
    
    private func saveData(){
        do{
            try container.viewContext.save()
            fetchFruits()
        }catch let r{
            print(r.localizedDescription)
        }
    }
}


struct CoreDataView: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText:String = ""
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                TextField("Add Fruite Here", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                Button {
                    guard !textFieldText.isEmpty else {return}
                    vm.addFruite(name: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.systemBlue))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                List{
                    ForEach(vm.savedEntities) { fruite in
                        Text(fruite.name ?? "NO NAME")
                            .onTapGesture {
                                vm.updateFruite(fruite: fruite)
                            }
                    }.onDelete(perform:vm.deleteFruite)
                }
                .listStyle(.plain)

                    
            }
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    CoreDataView()
}
