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
            
            CollectionView(viewModel: ResultViewModel())
                .tabItem {
                    Image(systemName: "camera.macro")
                    Text("Collection")
                }
            
            
            CombatView()
                .tabItem {
                    Image(systemName: "apple.meditate")
                    Text("Garden")
                }
            
//            UserView()
//                .tabItem {
//                    Image(systemName: "person")
//                    Text("Me")
//                }
        }
    }
}

struct FlowerGoTabView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerGoTabView()
    }
}
