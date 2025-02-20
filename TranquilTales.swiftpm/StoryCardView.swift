
import SwiftUI
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

struct StoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        StoryCardView(title: "Sample Story", imageName: "book", isPlaying: false, playAction: {})
    }
}
