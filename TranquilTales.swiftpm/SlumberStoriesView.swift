
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
        ("Moonlit River", "river", "moonlit_river"),
        ("Enchanted Waterfall", "waterfall", "enchanted_waterfall"),
        ("Whispering Pines", "pines", "whispering_pines"),
        ("Golden Sands", "beach", "golden_sands"),
        ("Twilight Valley", "valley", "twilight_valley"),
        ("Silent Desert", "desert", "silent_desert"),
        ("Frosty Mountains", "mountains", "frosty_mountains"),
        ("Aurora Dreams", "aurora", "aurora_dreams"),
        ("Sapphire Lake", "lake", "sapphire_lake"),
        ("Serene Garden", "garden", "serene_garden"),
        ("Mystic Rainforest", "rainforest", "mystic_rainforest"),
        ("Crystal Caverns", "cavern", "crystal_caverns")
    ].shuffled() 
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Text("Slumber Stories")
                    .font(.largeTitle).foregroundColor(.white).bold().shadow(radius: 5)
                
                ScrollView {
                    ForEach(stories, id: \.0) { story in
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
            }
            .padding(.bottom, 20)
        }
        .animation(.easeInOut)
    }
}
