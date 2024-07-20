import SwiftUI
import MapKit

struct FlowerGoTabView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.4075, longitude: -71.1190), span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))

    var body: some View {
        TabView {
            MapView(region: $region)
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            
            GardenView()
                .tabItem {
                    Image(systemName: "apple.meditate")
                    Text("Garden")
                }
            
            CamView()
                .tabItem {
                    Image(systemName: "camera.viewfinder")
                    Text("AR")
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
