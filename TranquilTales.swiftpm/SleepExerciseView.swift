
import SwiftUI
struct SleepExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentExercise: Int = 0
    @State private var progress: CGFloat = 0.0
    @State private var isBreathingIn = true
    @State private var timer: Timer?

    let exercises = [
        ("Deep Breathing", "Focus on breathing deeply and slowly. Inhale for 4 seconds, hold for 4 seconds, exhale for 4 seconds. Repeat.", "lungs.fill"),
        ("Progressive Muscle Relaxation", "Tense and relax your muscles progressively from feet to head.", "figure.stand"),
        ("Gentle Neck Stretch", "Slowly tilt your head to one side, then to the other side.", "person.circle"),
        ("Leg Raises", "Raise each leg slowly while lying on your back to relax.", "figure.walk")
    ]
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 5)
            
            VStack(spacing: 40) {
                Text("Prepare for a Restful Sleep")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .shadow(radius: 5)
                    .padding(.top, 40)
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .foregroundColor(Color.white.opacity(0.2))
                        .frame(width: 200, height: 200)
                    
                    Circle()
                        .trim(from: 0.0, to: progress)
                        .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                        .foregroundColor(isBreathingIn ? Color.green : Color.orange)
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut(duration: 4), value: progress)
                        .frame(width: 200, height: 200)
                        .onAppear {
                            startBreathingAnimation()
                        }
                    
                    VStack {
                        Image(systemName: exercises[currentExercise].2)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                        
                        Text(exercises[currentExercise].0)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                        
                        Text(exercises[currentExercise].1)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
                Spacer()
                if currentExercise < exercises.count - 1 {
                    Button(action: nextExercise) {
                        Text("Next Exercise")
                            .font(.title2)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.purple)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    }
                } else {
                    Button(action: endExercises) {
                        Text("End Session")
                            .font(.title2)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.purple)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    }
                }
                
                Spacer()
            }
        }
        .onAppear(perform: startBreathingAnimation)
    }
    private func startBreathingAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: true) { _ in
            DispatchQueue.main.async {
                withAnimation {
                    progress = isBreathingIn ? 1.0 : 0.0
                }
                isBreathingIn.toggle()
            }
        }
    }
    private func nextExercise() {
        timer?.invalidate()
        currentExercise += 1
        startBreathingAnimation()
    }
    
    private func endExercises() {
        timer?.invalidate()
        currentExercise = 0
        progress = 0.0
        isBreathingIn = true
        presentationMode.wrappedValue.dismiss() 
    }
}
struct SleepExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        SleepExerciseView()
    }
}
