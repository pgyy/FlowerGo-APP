import SwiftUI

struct ContentView: View {
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
                HomeView()
            }
        }
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home Screen")
            .font(.largeTitle)
            .foregroundColor(.black)
    }
}

// MARK: - Previews

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
