//
//  DetailView.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import SwiftUI

struct DetailView: View {
    @StateObject private var viewmodel: ViewModel
    
    init(loadPersonAction: @escaping LoadPersonUsecase, target: Person.ID) {
        _viewmodel = StateObject(wrappedValue: ViewModel(loadPersonAction: loadPersonAction, idnt: target))
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
            HStack {
                Spacer()
                AsyncImage(url: URL(string: item.photo ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }.frame(width: 200, height: 200)
                Spacer()
            }.listRowBackground(Color.clear)
            
            Section("Information") {
                InlineKeyValueTextCell(key: "Name", value: item.name, fixedKeyWidth: 80)
                InlineKeyValueTextCell(key: "Nick", value: item.username, fixedKeyWidth: 80)
                InlineKeyValueTextCell(key: "Email", value: item.email, fixedKeyWidth: 80)
                InlineKeyValueTextCell(key: "Age", value: String(item.age), fixedKeyWidth: 80)
                InlineKeyValueTextCell(key: "Region", value: item.country, fixedKeyWidth: 80)
                InlineKeyValueTextCell(key: "Phone", value: item.cellphone, fixedKeyWidth: 80)
            }
//            Button(action: {}, label: {Text("Test")})
//                .buttonStyle(.plain)
            
//            Button {
//                /* */
//            } label: {
//                Text("BUTTON")
//                    .padding()
//                    .frame(width: 200)
//                    .background(.blue)
//                    .cornerRadius(14)
//            }
            Section {
                Button(action: {
                    //
                }) {
                    HStack {
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                }
                .foregroundColor(.white)
                .padding(10)
                .background(Color.accentColor)
                .cornerRadius(8)
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
//        DetailView()
//    }
//}
