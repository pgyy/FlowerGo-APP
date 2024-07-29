import SwiftUI

struct FlowerGoTabView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color(hex: 0x8e8e93))
    }
    
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
            
            GardenView()
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

//
//struct FlowerGoTabView: View {
//    var body: some View {
//        TabView {
//            ContentView()
//                .tabItem {
//                    Image(systemName: "house")
//                    Text("Home")
//                }
//            
//            MPV()
//                .tabItem {
//                    Image(systemName: "map")
//                    Text("Map")
//                }
//            
//            CollectionView(viewModel: ResultViewModel())
//                .tabItem {
//                    Image(systemName: "camera.macro")
//                    Text("Collection")
//                }
//            
//            
//            CombatView()
//                .tabItem {
//                    Image(systemName: "apple.meditate")
//                    Text("Garden")
//                }
//            
////            UserView()
////                .tabItem {
////                    Image(systemName: "person")
////                    Text("Me")
////                }
//        }
//    }
//}
//
//struct FlowerGoTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlowerGoTabView()
//    }
//}
//
//
