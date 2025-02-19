
import AVKit
import SwiftUI
class AudioPlayer: ObservableObject {
    var player: AVPlayer?
    
    func playAudio(named fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") {
            player = AVPlayer(url: url)
            player?.play()
        } else {
            print("Audio file not found.")
        }
    }
    func stopAudio() {
        player?.pause()
        player = nil
    }
}


