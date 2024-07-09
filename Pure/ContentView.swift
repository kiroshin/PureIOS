//
//  ContentView.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//


import SwiftUI

struct ContentView: View {
    let service: Serving
    let isRegionStored: Stored<Bool>
    let applyRegionAction: ApplyRegionUsecase
    
    @State private var stackPath = NavigationPath()
    @State private var isRegion: Bool
    
    init(_ service: Serving) {
        self.service = service
        self.isRegionStored = service.appState.stored(keyPath: \.field.isRegion)
        self.applyRegionAction = service.applyRegionAction
        self._isRegion = .init(initialValue: service.appState.value.field.isRegion)
    }

    var body: some View {
        NavigationStack(path: $stackPath) {
            homeView()
        }.mxReceive(isRegionStored) {
            Swift.print("* Received: \($0)")
        }
        .task(id: isRegion) {
            Swift.print("* Send: \(isRegion)")
            await applyRegionAction(isRegion)
        }
    }
}

private extension ContentView {
    @ViewBuilder func homeView() -> some View {
        HomeView(service)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Toggle(isOn: $isRegion, label: { EmptyView() }).toggleStyle(.switch)
                }
            }.navigationDestination(for: Person.ID.self) { uid in
                detailView(uid: uid)
            }.navigationTitle("Home")
    }
    
    @ViewBuilder func detailView(uid: Person.ID) -> some View {
        DetailView(service, target: uid)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Toggle(isOn: $isRegion, label: { EmptyView() }).toggleStyle(.switch)
                }
            }.navigationTitle("Detail")
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(Raft.shared)
//    }
//}

