//
//  HomeView.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import SwiftUI

struct HomeView: View {
    private let lastMetasState: Stored<That>
    @State var itemsState: UiState<[Item]> = UiState.ready
    
    init(appState: AppState) {
        lastMetasState = appState.stored { That(roger: $0) }
    }
    
    var body: some View {
        content
            .navigationTitle("Home")
            .mxReceive(
                lastMetasState.map {
                    switch $0.last {
                    case .success: return UiState.success($0.metas.map { pm in Item.from(meta: pm)})
                    case .failure: return UiState.failure("데이터를 로드할 수 없습니다.")
                    default: return UiState.ready
                    }
                }
            ) { itemsState = $0 }
    }
    
    @ViewBuilder private var content: some View {
        switch itemsState {
        case let .success(items): loadItemsList(items: items)
        case let .failure(msg): loadErrorMessage(msg)
        default: EmptyView()
        }
    }
}

private extension HomeView {
    func loadItemsList(items: [Item]) -> some View {
        List { ForEach(items) { item in
            NavigationLink(value: item.id) {
                InlineKeyValueTextCell(
                    key: item.region,
                    value: item.nick,
                    fixedKeyWidth: 4 * 10
                )
            }
        } }.listStyle(.plain)
    }
    
    func loadErrorMessage(_ message: String) -> some View {
        Text("웁스... \(message)")
    }
}

extension HomeView {
    struct That: Equatable {
        let last: Roger.Signal
        let metas: [Person.Meta]
        
        init(roger: Roger) {
            last = roger.sys.last
            metas = roger.query.metas
        }
    }
    
    struct Item: Identifiable {
        let id: Person.ID
        let nick: String
        let age: Int
        let region: String
    }
}

private extension HomeView.Item {
    static func from(meta: Person.Meta) -> HomeView.Item {
        return .init(id: meta.id, nick: meta.name, age: meta.age, region: meta.country)
    }
}



//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}



/*  만약에 뷰모델을 만든다면
extension HomeView {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published var itemsState: UiState<[Item]> = UiState.ready
        
        init(_ service: Serving) {
            let lastMetasState = service.appState.mxFlow { That(roger: $0) }
            lastMetasState.map {
                switch $0.last {
                case .success: return UiState.success($0.metas.map { pm in Item.from(meta: pm)})
                case .failure: return UiState.failure("데이터를 로드할 수 없습니다.")
                default: return UiState.ready
                }
            }.mxAssign(to: &$itemsState)
        }
    }
}
*/


