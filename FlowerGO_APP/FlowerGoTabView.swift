import SwiftUI

struct FlowerGoTabView: View {
    @StateObject private var viewModel = ResultViewModel()
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color(hex: 0x8e8e93))
    }
    
    var body: some View {
        TabView {
            NavigationView {
                ContentView()
            }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            NavigationView {
                MPV()
            }
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            NavigationView {
                CollectionView(viewModel: viewModel)
            }
                .tabItem {
                    Image(systemName: "camera.macro")
                    Text("Collection")
                }
            NavigationView {
//                GardenView(viewModel: viewModel)
            }
                .tabItem {
                    Image(systemName: "apple.meditate")
                    Text("Garden")
                }
        }
        .tint(Color(hex: 0x007aff))
        .ignoresSafeArea(.all, edges: [.bottom])
        .toolbarBackground(.ultraThickMaterial, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .navigationBarHidden(true)
    }
}

#Preview {
    FlowerGoTabView()
}
