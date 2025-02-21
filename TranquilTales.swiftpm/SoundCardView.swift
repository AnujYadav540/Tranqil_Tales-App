
import SwiftUI
struct SoundCardView: View {
    let soundName: String
    let soundFile: String
    @Binding var selectedSound: String?
    @Binding var isPlaying: Bool
    @ObservedObject var audioPlayer: AudioPlayer
    var body: some View {
        Button(action: {
            if selectedSound == soundFile {
                audioPlayer.stopAudio()
                selectedSound = nil
                isPlaying = false
            } else {
                audioPlayer.playAudio(named: soundFile)
                selectedSound = soundFile
                isPlaying = true
            }
        }) {
            HStack {
                Text(soundName)
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
                
                Spacer() // This will push the play button to the right
                
                Image(systemName: selectedSound == soundFile && isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.yellow)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.2)))
            .shadow(radius: 5)
        }
        .padding(.horizontal)
    }
}
