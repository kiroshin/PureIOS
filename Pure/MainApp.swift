//
//  MainApp.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//

import SwiftUI

@main
struct MainApp: App {
#if DEBUG
    let service: Serving = ProcessInfo.isPreviewMode ? Raft.shared : Vessel()
#else
    let service = Vessel()
#endif

    var body: some Scene {
        WindowGroup {
            ContentView(service: service)
        }
    }
}


#if DEBUG
private extension ProcessInfo {
    static var isPreviewMode: Bool {
        processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
#endif
