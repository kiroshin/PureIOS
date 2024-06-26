//
//  PureApp.swift
//  Pure
//
//  Created by Kiro on 2024/06/26.
//

import SwiftUI

@main
struct PureApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
