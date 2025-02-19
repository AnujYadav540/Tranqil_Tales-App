
import SwiftUI
import AVKit

struct DreamGuardianView: View {
    @ObservedObject var gameManager = DreamGuardianManager()
    @State private var showRelaxationPopup = false
    @State private var showDreamQuest = false
    @State private var isPaused = true
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Text("Sleep Guardian")
                    .font(.largeTitle).foregroundColor(.white).bold().shadow(radius: 5)
                    .padding(.top, 40)
                
                Text("Relaxation Timer: \(gameManager.relaxationLevel)")
                    .font(.title2).foregroundColor(.white).padding()
                Button(action: {
                    if isPaused {
                        gameManager.startOrResumeRelaxation()
                        showRelaxationPopup = true
                    } else {
                        gameManager.pauseRelaxation() //
                    }
                    isPaused.toggle()
                }) {
                    Text(isPaused ? "Play Relaxation" : "Pause Relaxation") // Dynamic button text
                        .bold()
                }
                .padding()
                .background(isPaused ? Color.blue : Color.orange)
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                .alert(isPresented: $showRelaxationPopup) {
                    Alert(
                        title: Text("Relaxation Started"),
                        message: Text("Listen to soothing sounds while relaxing."),
                        dismissButton: .default(Text("Got it!"))
                    )
                }
                
                Button("Enter Dream Quest") {
                    showDreamQuest = true
                }
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .fullScreenCover(isPresented: $showDreamQuest) {
            DreamQuestView()
        }
    }
}
