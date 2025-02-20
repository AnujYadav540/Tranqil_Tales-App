
import Foundation
import AVKit

class AudioPlayer: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    func playAudio(named name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        }
    }
    func stopAudio() {
        audioPlayer?.stop()
    }
}
