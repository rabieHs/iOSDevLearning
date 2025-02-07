//
//  HapticsView.swift
//  iOSDevLearning
//
//  Created by Rabie on 06/02/2025.
//

import SwiftUI


class HapticManager{
    static let instance = HapticManager()
    
    func notification(type : UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
        
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsView: View {
    var body: some View {
        VStack(spacing:20){
            Text("Notification Haptics")
            Button("Success Haptic") {HapticManager.instance.notification(type: .success)}
            Button("Warning Haptic") {HapticManager.instance.notification(type: .warning)}
            Button("Error Haptic") {HapticManager.instance.notification(type: .error)}
            Divider()
            Text("Impact Haptics")
            Button("Soft Imopact") {HapticManager.instance.impact(style: .soft)}
            Button("Heavy Imopact") {HapticManager.instance.impact(style: .heavy)}
            Button("Light Imopact") {HapticManager.instance.impact(style: .light)}
            Button("Meduim Imopact") {HapticManager.instance.impact(style: .medium)}
            Button("Rigid Imopact") {HapticManager.instance.impact(style: .rigid)}

        }    }
}

#Preview {
    HapticsView()
}
