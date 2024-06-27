//
//  HomeView.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import SwiftUI

struct HomeView: View {
    private let rogerThat: Stored<That>
    @State var itemsState: UiState<[Item]> = UiState.ready
    
    init(appState: AppState) {
        rogerThat = appState.stored { That(roger: $0) }
    }
    
    var body: some View {
        content
            .mxReceive(
                rogerThat.map { switch $0.last {
                    case .success: return UiState.success($0.metas.map { pm in Item.from(meta: pm)})
                    case .failure: return UiState.failure("데이터를 로드할 수 없습니다.")
                    default: return UiState.ready
                } }
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
                    key: item.generation,
                    value: item.nick,
                    fixedKeyWidth: 4 * 20
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
        
        var generation: String { switch age {
            case 0..<13: return "KID"
            case 13...19: return "TEEN"
            case 20..<40: return "YOUTH"
            case 40..<60: return "MIDDLE"
            case 60..<70: return "SENIOR"
            default: return "OLD"
        } }
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


