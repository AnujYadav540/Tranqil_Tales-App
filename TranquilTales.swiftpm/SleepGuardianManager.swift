
import SwiftUI
import Combine
class SleepGuardianManager: ObservableObject {
    @Published var relaxationLevel: Int = 0
    private var relaxationTimer: Timer?

    func startOrResumeRelaxation() {
        relaxationTimer?.invalidate()
        relaxationTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.relaxationLevel += 1
            if self.relaxationLevel >= 100 {
                timer.invalidate()
            }
        }
    }
    func pauseRelaxation() {
        relaxationTimer?.invalidate()
    }
}
