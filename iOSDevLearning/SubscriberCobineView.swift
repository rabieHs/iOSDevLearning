//
//  SubscriberCobineView.swift
//  iOSDevLearning
//
//  Created by Rabie on 18/02/2025.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count : Int = 0
    var timer : AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textfieldTexd : String = ""
    @Published var textIsValid : Bool = false
    
    @Published var  showButton: Bool = false
    
    
    
    
    func addTextFieldSubscriber(){
        $textfieldTexd
        
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
        .map { text in
            
            if text.count > 3 {
                return true
            }
            return false
        }
        
        // using assign cant make the self weak which is not good because we acces to self here. so its better to use sink
       // .assign(to:\.textIsValid, on: self)
        .sink(receiveValue: { [weak self] isValid in
            guard let self = self else {return}
            self.textIsValid = isValid
        })
        .store(in: &cancellables)
    }
    
    func setupTimer(){
        
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else {return}
                self.count += 1
                if  self.count >= 10
                {
                    for item in self.cancellables{
                        item.cancel()
                    }
                    
                }
                
            }
        .store(in: &cancellables)}
        
      func  addButtonSubscriber(){
          $textIsValid.combineLatest($count)
              .sink { [weak self] valid, count in
                  guard let self = self else {return}
                  
                  if valid && count >= 10 {
                      self.showButton = true
                  }else{
                      self.showButton = false
                  }
              }
              .store(in: &cancellables)
        }
    
    
    init() {
        setupTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
}

struct SubscriberCobineView: View {
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack{
            
            
            Text("\(vm.count)")
                .font(.largeTitle)
            
            Text("\(vm.textIsValid)")
            
            TextField("text", text: $vm.textfieldTexd)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(10)
                .overlay(ZStack{
                    Image(systemName: "xmark")
                        .foregroundStyle(.red)
                        .opacity(
                            vm.textfieldTexd.count < 1 ? 0 :
                            vm.textIsValid ? 0 : 1 )
                    
                    Image(systemName: "checkmark")
                        .foregroundStyle(.green)
                        .opacity(vm.textIsValid ? 1 : 0 )
                }
                    .font(.headline)
                    .padding(.trailing)
                         
                         ,alignment: .trailing
                )
            
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            }
            .disabled(!vm.showButton)


        }
        .padding()
    }
}

#Preview {
    SubscriberCobineView()
}
