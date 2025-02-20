
import SwiftUI
import AVKit
struct RelaxationView: View {
    @State private var selectedSound: String? = nil
    @State private var isPlaying = false
    @StateObject private var audioPlayer = AudioPlayer()
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Text("Relaxation Sounds")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .shadow(radius: 5)
                    .padding(.top, 40)
                
                ScrollView {
                    SoundSelectionView(selectedSound: $selectedSound, isPlaying: $isPlaying, audioPlayer: audioPlayer)
                }
            }
            .padding(.bottom, 20)
        }
    }
}

