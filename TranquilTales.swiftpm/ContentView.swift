
import SwiftUI
import AVKit
import AVFoundation
import AudioToolbox

// 🎶 Audio Story Player (Handles Playback)
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

// 🌙 DREAM GUARDIAN MANAGER
class DreamGuardianManager: ObservableObject {
    @Published var relaxationLevel: Int = 0
    @Published var showDreamQuest: Bool = false
    @Published var showMessage: Bool = false
    
    private var audioPlayer: AVAudioPlayer?
    
    func startRelaxation() {
        relaxationLevel += 5
        playCalmMusic()
        showMessage = true
        
        AudioServicesPlaySystemSound(1519) // Pop haptic feedback
        
        if relaxationLevel >= 20 {
            showDreamQuest = true
        }
    }
    
    func playCalmMusic() {
        if let soundURL = Bundle.main.url(forResource: "calm_music", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing calm music: \(error.localizedDescription)")
            }
        }
    }
}

// 🌙 Main Content View with Tabs
struct ContentView: View {
    var body: some View {
        TabView {
            SlumberStoriesView().tabItem { Label("Slumber Stories", systemImage: "cloud.moon.fill") }
            RelaxationView().tabItem { Label("Relaxation", systemImage: "music.note.list") }
            DreamGuardianView().tabItem { Label("Dream Guardian", systemImage: "shield.fill") }
        }
        .accentColor(.yellow) // Improved UI theme accent
    }
}

// ✨ SLUMBER STORIES VIEW
struct SlumberStoriesView: View {
    @State private var currentlyPlaying: String? = nil
    @StateObject private var audioPlayer = AudioPlayer()
    
    let stories = [
        ("The Night Forest", "forest", "night_forest"),
        ("Starry Sky Voyage", "starry_sky", "starry_sky"),
        ("Dreamy Castle", "castle", "dreamy_castle"),
        ("Magical Meadows", "meadow", "magical_meadow"),
        ("Moonlit River", "river", "moonlit_river")
    ]
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Text("✨ Slumber Stories")
                    .font(.largeTitle).foregroundColor(.white).bold().shadow(radius: 5)
                
                ScrollView {
                    ForEach(stories.shuffled(), id: \.0) { story in
                        StoryCardView(
                            title: story.0,
                            imageName: story.1,
                            isPlaying: currentlyPlaying == story.0,
                            playAction: {
                                if currentlyPlaying == story.0 {
                                    audioPlayer.stopAudio()
                                    currentlyPlaying = nil
                                } else {
                                    audioPlayer.playAudio(named: story.2)
                                    currentlyPlaying = story.0
                                }
                            }
                        )
                    }
                }
            }.padding(.bottom, 20)
        }
        .animation(.easeInOut) // Smooth transition animations for UI interactions
    }
}

// 🌙 DREAM GUARDIAN VIEW
struct DreamGuardianView: View {
    @ObservedObject var gameManager = DreamGuardianManager()
    @State private var showRelaxationPopup = false // Control the popup alert
    @State private var showDreamQuest = false // New state to control Dream Quest full screen

    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Text("🌙 Dream Guardian")
                    .font(.largeTitle).foregroundColor(.white).bold().shadow(radius: 5)
                    .padding(.top, 40)
                
                Text("Relaxation Level: \(gameManager.relaxationLevel)")
                    .font(.title2).foregroundColor(.white).padding()
                
                Button(action: {
                    gameManager.startRelaxation()
                    showRelaxationPopup = true // Show the popup when the button is clicked
                }) {
                    Text("Begin Nightly Relaxation").bold()
                }
                .padding()
                .background(BlurView(style: .systemUltraThinMaterialDark))
                .cornerRadius(15)
                .shadow(radius: 5)
                .alert(isPresented: $showRelaxationPopup) { // Popup alert when button is clicked
                    Alert(
                        title: Text("Relaxation Started"),
                        message: Text("Listen to soothing sounds while relaxing."),
                        dismissButton: .default(Text("Got it!"))
                    )
                }

                // Dream Quest Button
                Button("Enter Dream Quest") {
                    showDreamQuest = true // Show the Dream Quest view
                }
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        // Full screen cover for Dream Quest
        .fullScreenCover(isPresented: $showDreamQuest) {
            DreamQuestView()
        }
    }
}

// Improved Sound Selection View with Reusable Components
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
        // More sounds...
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
                
                // Scrollable sound list
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
        .navigationBarHidden(true) // Hide default navigation bar for a clean look
    }
}

// Sound Card View for Reusability and Cleaner Code
struct SoundCardView: View {
    var soundName: String
    var soundFile: String
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
                    .font(.title3)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: selectedSound == soundFile ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25) // Made the button larger
                    .foregroundColor(.yellow)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.2)).shadow(radius: 5))
        }
    }
}

// 🌟 BACKGROUND VIEW (Reusable)
struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.8)]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

// 🌠 DREAM QUEST VIEW
struct DreamQuestView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("🌠 Dream Quest 🌠")
                .font(.largeTitle)
                .padding()
            
            Text("Close your eyes and imagine a magical adventure…")
                .padding()
            
            Button("Wake Up") {
                dismiss()
            }
            .font(.title3)
            .padding(10)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

// 🌟 BLUR VIEW (Glassmorphism Effect)
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
}

// ✅ PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// 🌙 STORY CARD VIEW (For displaying individual story cards)
struct StoryCardView: View {
    let title: String
    let imageName: String
    let isPlaying: Bool
    let playAction: () -> Void
    
    var body: some View {
        Button(action: playAction) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                    .background(Circle().fill(isPlaying ? Color.green.opacity(0.7) : Color.white.opacity(0.2)))
                    .overlay(
                        Circle().stroke(isPlaying ? Color.green : Color.clear, lineWidth: 4)
                    )
                
                Text(title)
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
                
                Spacer()
                
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
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

// 🌙 RELAXATION VIEW
struct RelaxationView: View {
    @State private var selectedSound: String? = nil
    @State private var isPlaying = false
    @StateObject private var audioPlayer = AudioPlayer()
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Text("🌿 Relaxation Sounds")
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

