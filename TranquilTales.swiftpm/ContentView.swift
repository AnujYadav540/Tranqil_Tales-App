
import SwiftUI
struct ContentView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    var body: some View {
        TabView {
            SlumberStoriesView()
                .tabItem { Label("Slumber Stories", systemImage: "cloud.moon.fill") }
            RelaxationView()
                .tabItem { Label("Relaxation", systemImage: "music.note.list") }
            SleepGuardianView()
                .tabItem { Label("Sleep Guardian", systemImage: "shield.fill") }
        }
        .accentColor(.yellow)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
