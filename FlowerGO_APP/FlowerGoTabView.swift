import SwiftUI
import MapKit

struct FlowerGoTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            MPV()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            
            GardenView()
                .tabItem {
                    Image(systemName: "apple.meditate")
                    Text("Garden")
                }
            
            
            CombatView()
                .tabItem {
                    Image(systemName: "shield.lefthalf.filled")
                    Text("Defend")
                }
            
            UserView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Me")
                }
        }
    }
}

struct FlowerGoTabView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerGoTabView()
    }
}
