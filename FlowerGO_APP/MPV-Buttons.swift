//
//  MVP-Buttons.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/23/24.
//

import SwiftUI
import MapKit

struct MPV_Buttons: View {
    var body: some View {
        HStack {
            Button {
                search(for: "flower")
            } label: {
                Label("Flowers", systemImage: "flower")
            }
            .buttonStyle(.borderedProminent)
        }
        .labelStyle(.iconOnly)
    }
}

func search(for query: String) {
    
}

#Preview {
    MPV_Buttons()
}
