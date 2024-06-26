//
//  ContentView.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//


import SwiftUI

struct ContentView: View {
    let service: Serving
    @State private var stackPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $stackPath) {
            homeView()
        }
    }
}

private extension ContentView {
    @ViewBuilder func homeView() -> some View {
        HomeView(appState: service.appState)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
            }
            .navigationDestination(for: Person.ID.self) { uid in
                detailView(uid: uid)
            }
    }
    
    @ViewBuilder func detailView(uid: Person.ID) -> some View {
        DetailView(loadPersonAction: service.loadPersonAction, target: uid)
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
