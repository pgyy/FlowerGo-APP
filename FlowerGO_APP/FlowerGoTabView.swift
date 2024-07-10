//
//  SwiftUIView.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/10/24.
//

import SwiftUI

struct FlowerGoTabView: View {
    var body: some View {
        
        TabView {
            MapView()
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerGoTabView()
    }
}
