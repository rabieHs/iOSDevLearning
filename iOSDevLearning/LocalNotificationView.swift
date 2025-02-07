//
//  LocalNotificationView.swift
//  iOSDevLearning
//
//  Created by Rabie on 06/02/2025.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization(){
        let options : UNAuthorizationOptions = [.alert,.badge,.sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            
        }
    }
    
    func scheduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "This is My First Notification"
        content.subtitle = "This is soooo easy!"
        content.sound = .default
        content.badge = 1
        
        //time:
       let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        
        
        //calender:
//        var dateCompoents = DateComponents()
//        dateCompoents.hour = 13
//        dateCompoents.minute = 8
//        dateCompoents.weekday = 6 // every friday
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompoents, repeats: true)
        
        
        //location:
        
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger:trigger )
        UNUserNotificationCenter.current().add(request) { error in
            
        }
    }
    
    func cancelNotification(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
struct LocalNotificationView: View {
    var body: some View {
        VStack(spacing:40){
            Button("Request Permission"){
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification"){
                NotificationManager.instance.scheduleNotification()
            }
            
            Button("Cancel Notification"){
                NotificationManager.instance.scheduleNotification()
            }
        }
        .onAppear{
            UNUserNotificationCenter.current().setBadgeCount(0)
        }
    }
}
#Preview {
    LocalNotificationView()
}
