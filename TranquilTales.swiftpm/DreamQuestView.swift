


import SwiftUI
struct DreamQuestView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.purple.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Welcome to the Dream Quest!")
                    .font(.largeTitle).foregroundColor(.white).bold().padding()
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Exit Dream Quest")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.purple)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.bottom, 40)
            }
        }
    }
}


