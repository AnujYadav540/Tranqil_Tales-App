

import SwiftUI
import AVKit
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
                Text("Slumber Stories")
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


