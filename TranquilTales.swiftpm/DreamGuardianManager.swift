
import SwiftUI
import Combine
class DreamGuardianManager: ObservableObject {
    @Published var relaxationLevel: Int = 0
    private var relaxationTimer: Timer?

    func startOrResumeRelaxation() {
        // Starts the timer without resetting relaxationLevel
        relaxationTimer?.invalidate()
        relaxationTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.relaxationLevel += 1
            if self.relaxationLevel >= 100 {
                timer.invalidate()
            }
        }
    }

    func pauseRelaxation() {
        // Pauses the timer without resetting relaxationLevel
        relaxationTimer?.invalidate()
    }
}
