//
//  DetailView.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import SwiftUI

struct DetailView: View {
    @StateObject private var viewmodel: ViewModel
    
    init(_ service: Serving, target: Person.ID) {
        _viewmodel = StateObject(wrappedValue: ViewModel(service, idnt: target))
    }
    
    var body: some View {
        switch viewmodel.itemState {
            case let .success(item): profileView(item)
        case let .failure(msg): errorView(msg)
        default: EmptyView()
        }
    }
}

private extension DetailView {
    func profileView(_ item: ViewModel.Item) -> some View {
        Form {
            CenterCircleImage(url: item.photo ?? "").listRowBackground(Color.clear)
            Section("Information") {
                InlineKeyValueTextCell(key: "Name", value: item.name, fixedKeyWidth: 80)
                InlineKeyValueTextCell(key: "Nick", value: item.username, fixedKeyWidth: 80)
                InlineKeyValueTextCell(key: "Email", value: item.email, fixedKeyWidth: 80)
                InlineKeyValueTextCell(key: "Age", value: String(item.age), fixedKeyWidth: 80)
                if viewmodel.isRegion {
                    InlineKeyValueTextCell(key: "Region", value: item.country, fixedKeyWidth: 80)
                }
                InlineKeyValueTextCell(key: "Phone", value: item.cellphone, fixedKeyWidth: 80)
            }
            Button(viewmodel.moveText) {
                viewmodel.moveHere(isLeg: viewmodel.isRegion)
            }
        }
        //
    }
    
    func errorView(_ message: String) -> some View {
        Text("오..! \(message)")
    }
}


//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack() {
//            DetailView(Raft.shared, target: "ONE")
//        }
//    }
//}

