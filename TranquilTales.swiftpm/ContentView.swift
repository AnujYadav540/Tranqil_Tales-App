
import SwiftUI
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
