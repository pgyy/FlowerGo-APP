import SwiftUI

struct PreView: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.green
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("FLOWER")
                        .font(.system(size: 50, weight: .heavy, design: .serif))
                        .foregroundColor(.blue)
                        .padding()
                    Text("GO!")
                        .font(.system(size: 70, weight: .heavy, design: .serif))
                        .foregroundColor(.blue)
                        .onTapGesture {
                            self.isActive = true
                        }
                }
            }
            .navigationDestination(isPresented: $isActive) {
                FlowerGoTabView()
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Previews

#Preview {
    PreView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
