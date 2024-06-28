//
//  DetailViewModel.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import Foundation

extension DetailView {
    @MainActor
    final class ViewModel: ObservableObject {
        private let loadPersonAction: LoadPersonUsecase
        @Published var isRegion: Bool = true
        @Published var itemState: UiState<Item> = UiState.ready
        
        init(_ service: Serving, idnt: Person.ID) {
            self.loadPersonAction = service.loadPersonAction
            service.appState.stored(keyPath: \.field.isRegion).give(to: &$isRegion)
            loadPerson(idnt: idnt)
        }
    }
}

extension DetailView.ViewModel {
    private func loadPerson(idnt: String) { Task { do {
        let person = try await loadPersonAction(idnt)
        itemState = UiState.success(Item.from(person))
    } catch {
        itemState = UiState.failure(error.localizedDescription)
    } } }
    
}

extension DetailView.ViewModel {
    struct Item: Identifiable {
        let id: String
        var name: String
        var username: String
        var gender: String
        var email: String
        var age: Int
        var country: String
        var cellphone: String
        var photo: String?
        
        static func from(_ person: Person) -> Item {
            return Item(id: person.id,
                        name: person.name,
                        username: person.username,
                        gender: person.gender.rawValue,
                        email: person.email,
                        age: person.age,
                        country: person.country,
                        cellphone: person.cellphone ?? "000-0000",
                        photo: person.photo)
        }
    }
}

//private extension URL {
//    init?(photo: String?) {
//        if let photo = photo {
//            self.init(string: photo)
//        }
//        return nil
//    }
//}









//@State var name: String = ""
//private let llState: AppState<Roger.Route>
//
//init(_ service: Serving) {
//    lastMetasState = service.appState.mxFlow { That(roger: $0) }
//    llState = service.appState.mxFlow(keyPath: \.route)
//}

//    .mxReceive(
//        llState.map { r in
//            print("=== 받았다 : \(r) ===")
//            return r.uis
//        }
//    ) { name = $0 }
