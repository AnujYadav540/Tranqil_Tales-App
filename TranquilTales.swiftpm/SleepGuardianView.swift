
import SwiftUI
import AVKit
struct SleepGuardianView: View {
    @ObservedObject var gameManager = SleepGuardianManager()
    @State private var showRelaxationPopup = false
    @State private var showSleepExercise = false
    @State private var isPaused = true
    
    var body: some View {
        ZStack {
            // Background remains same (you can adjust this to your preference)
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Title
                Text("Sleep Guardian")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.4), radius: 6, x: 0, y: 4)
                    .padding(.top, 50)
                
                // Relaxation Timer Display
                Text("Relaxation Timer: \(gameManager.relaxationLevel)")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.9))
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                // Play/Pause Relaxation Button
                Button(action: {
                    if isPaused {
                        gameManager.startOrResumeRelaxation()
                        showRelaxationPopup = true
                    } else {
                        gameManager.pauseRelaxation()
                    }
                    isPaused.toggle()
                }) {
                    Text(isPaused ? "Play Relaxation" : "Pause Relaxation")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .frame(width: 250, height: 50)  // Fixed size
                        .background(isPaused ? Color.blue : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                        .padding(.top, 10)
                }
                .alert(isPresented: $showRelaxationPopup) {
                    Alert(
                        title: Text("Relaxation Started"),
                        message: Text("Enjoy soothing sounds"),
                        dismissButton: .default(Text("Got it!"))
                    )
                }
                
                // Start Sleep Exercise Button
                Button(action: {
                    showSleepExercise = true
                }) {
                    Text("Start Sleep Exercise")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .frame(width: 250, height: 50)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                }
                .padding(.bottom, 20)
            }
        }
        .fullScreenCover(isPresented: $showSleepExercise) {
            SleepExerciseView()
        }
    }
}
