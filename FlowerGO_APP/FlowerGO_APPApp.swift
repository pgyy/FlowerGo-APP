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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
