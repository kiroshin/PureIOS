//
//  MainApp.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//


import SwiftUI

@main
struct MainApp: App {
    let service = Vessel()

    var body: some Scene {
        WindowGroup {
            ContentView(service)
        }
    }
}

