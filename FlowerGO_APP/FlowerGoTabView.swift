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
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerGoTabView()
    }
}
