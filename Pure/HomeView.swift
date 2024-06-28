//
//  HomeView.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import SwiftUI

struct HomeView: View {
    private let thatStored: Stored<That>
    @State private var isRegion: Bool = true
    @State private var itemState: UiState<[Item]> = UiState.ready
    
    init(_ service: Serving) {
        thatStored = service.appState.stored { That(roger: $0) }
    }
    
    var body: some View {
        content.mxReceive(thatStored) {
            isRegion = $0.isRegion
            switch $0.last {
                case .success: itemState = UiState.success($0.metas.map { pm in Item.from(meta: pm)})
                case .failure: itemState = UiState.failure("Failed to load data!")
                default: itemState = UiState.ready
            }
        }
    }
    
    @ViewBuilder private var content: some View {
        switch itemState {
            case let .success(items) where isRegion == true: groupListView(items: items)
            case let .success(items) where isRegion == false: plainListView(items: items)
            case let .failure(msg): errMessageView(msg)
            default: EmptyView()
        }
    }
}

private extension HomeView {
    func groupListView(items: [Item]) -> some View {
        let groupItems = Dictionary(grouping: items) { $0.region }.sorted(by: {$0.key < $1.key})
        return List { ForEach(groupItems, id: \.key) { key, value in
            Section(key) { ForEach(value) { item in
                navLinkedCell(item: item)
            } }
        } }.listStyle(.plain)
    }
    
    func plainListView(items: [Item]) -> some View {
        List { ForEach(items) { item in
            navLinkedCell(item: item)
        } }.listStyle(.plain)
    }
    
    func errMessageView(_ message: String) -> some View {
        Text("Oops!... \(message)")
    }
    
    func navLinkedCell(item: Item) -> some View {
        NavigationLink(value: item.id) {
            InlineKeyValueTextCell(
                key: item.generation,
                value: item.nick,
                fixedKeyWidth: 4 * 20
            )
        }
    }
}

extension HomeView {
    struct That: Equatable {
        let last: Roger.Signal
        let isRegion: Bool
        let metas: [Person.Meta]
        
        init(roger: Roger) {
            last = roger.sys.last
            isRegion = roger.field.isRegion
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
//        NavigationStack() {
//            HomeView(Raft.shared)
//        }
//    }
//}

