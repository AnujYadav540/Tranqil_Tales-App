
import SwiftUI
struct SoundSelectionView: View {
    @Binding var selectedSound: String?
    @Binding var isPlaying: Bool
    @ObservedObject var audioPlayer: AudioPlayer
    
    let soothingSounds = [
        ("Ocean Waves", "ocean_waves"),
        ("Rainforest", "rainforest"),
        ("Mountain Breeze", "mountain_breeze"),
        ("Gentle Stream", "gentle_stream"),
        ("Soft Piano", "soft_piano"),
        ("Whale Songs", "whale_songs"),
        ("Wind Chimes", "wind_chimes"),
        ("Thunderstorm", "thunderstorm"),
        ("Bird Chirps", "bird_chirps"),
        ("Fire Crackling", "fire_crackling"),
        ("Wind Blowing", "wind_blowing"),
        ("Calm River", "calm_river")
    ]
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Text("Choose a Soothing Sound")
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
                    .shadow(radius: 5)
                    .padding(.top, 40)
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(soothingSounds, id: \.0) { sound in
                            SoundCardView(soundName: sound.0, soundFile: sound.1, selectedSound: $selectedSound, isPlaying: $isPlaying, audioPlayer: audioPlayer)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}
