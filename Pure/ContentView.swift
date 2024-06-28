//
//  ContentView.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//


import SwiftUI

struct ContentView: View {
    let service: Serving
    let isRegionStored: Stored<Bool>
    let applyRegionAction: ApplyIsRegionUsecase
    
    @State private var stackPath = NavigationPath()
    @State private var isRegion: Bool
    
    init(service: Serving) {
        self.service = service
        self.isRegionStored = service.appState.stored(keyPath: \.field.isRegion)
        self.applyRegionAction = service.applyIsRegionAction
        self._isRegion = .init(initialValue: service.appState.value.field.isRegion)
        // 그냥 isRegion 기본값을 할당해도 된다. true
    }

    var body: some View {
        NavigationStack(path: $stackPath) {
            homeView()
        }.mxReceive(isRegionStored) {
            Swift.print("* Received: \($0)")
            // isRegion = $0 // -- 여기서는 동기화가 굳이 필요 없음
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
//        ContentView()
//    }
//}
