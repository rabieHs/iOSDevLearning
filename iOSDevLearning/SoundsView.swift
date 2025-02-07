//
//  SoundsView.swift
//  iOSDevLearning
//
//  Created by Rabie on 06/02/2025.
//

import SwiftUI
import AVKit

class SoundManager: ObservableObject{
    static let instance = SoundManager()
    
    enum SoundOption:String{
        case tada
        case badum
    }
    
    var player : AVAudioPlayer?
    
    func playAudio(option:SoundOption){
        //guard let url = URL(string: "") else {return}
        guard let url = Bundle.main.url(forResource:option.rawValue, withExtension: ".mp3") else {return}
        do{
            player = try  AVAudioPlayer(contentsOf: url)
            player?.play()

        }catch{
            print("Error playing sound")
        }
    }
}

struct SoundsView: View {
    
    var body: some View {
        VStack(spacing:40){
            Button("Play Sound 1") {
                SoundManager.instance.playAudio(option:.tada)
            }
            Button("Play Sound 2") {
                SoundManager.instance.playAudio(option:.badum)

            }
        }
    }
}

#Preview {
    SoundsView()
}
