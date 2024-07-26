//
//  FlowerGO_APPApp.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/9/24.
//

import SwiftUI

@main
struct FlowerGO_APPApp: App {
    let persistenceController = PersistenceController.shared

//    init() {
//        setupTabBarAppearance()
//    }

    var body: some Scene {
        WindowGroup {
            PreView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
