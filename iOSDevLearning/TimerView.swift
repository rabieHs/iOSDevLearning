//
//  TimerView.swift
//  iOSDevLearning
//
//  Created by Rabie on 14/02/2025.
//

import SwiftUI

struct TimerView: View {
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
//    @State var currentDate: Date = Date()
//    var dateFormatter : DateFormatter {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .medium
//        return formatter
//    }
    
 //   -------
    
//    @State var count : Int = 10
//    @State var finishedText:String? = nil
    
//    ----------
    
//    @State var timeRemaining:String = ""
//    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
//    
//    func updateTimeRemainig(){
//        let remainig = Calendar.current.dateComponents([.hour,.minute,.second], from: .now, to: futureDate)
//        let hour = remainig.hour ?? 0
//        let minute = remainig.minute ?? 0
//        let second = remainig.second ?? 0
//        
//        timeRemaining = "\(hour):\(minute):\(second)"
//        
//    }
    
//    ------------
    @State var count:Int = 1
    
    var body: some View {
        ZStack{
            RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]), center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
//            Text("HI")
//                .font(.system(size: 100,weight: .bold,design: .rounded))
//                .foregroundStyle(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
            
           // Text(finishedText ?? "\(count)")
//            Text(timeRemaining)
//                .font(.system(size: 100,weight: .bold,design: .rounded))
//                .foregroundStyle(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
            
//            HStack{
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//
//                    
//            }
//            .foregroundStyle(.white)
//            .frame(width: 150)
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundStyle(.red)
                    .tag(1)
                Rectangle()
                    .foregroundStyle(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundStyle(.green)
                    .tag(3)
                Rectangle()
                    .foregroundStyle(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundStyle(.pink)
                    .tag(5)
            }.tabViewStyle(.page)
                .frame(height: 200)
        }
        .onReceive(timer) { _ in
            //currentDate = ""
            
            //--------
//            if count <= 1 {
//                finishedText = "Wow!"
//            }else{
//                count -= 1
//            }
            
            //updateTimeRemainig()
            
            withAnimation(.default) {
                count = count == 5 ? 1 : count+1
            }
        }
    }
}

#Preview {
    TimerView()
}
