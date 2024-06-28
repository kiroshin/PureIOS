//
//  DetailViewModel.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import Foundation

extension DetailView {
    @MainActor
    final class ViewModel: ObservableObject {
        private let loadPersonAction: LoadPersonUsecase
        private let moveHereAction: MoveHereUsecase
        
        @Published var isRegion: Bool = true
        @Published var itemState: UiState<Item> = UiState.ready
        @Published var moveText: String = "MOVE"
        
        init(_ service: Serving, idnt: Person.ID) {
            self.loadPersonAction = service.loadPersonAction
            self.moveHereAction = service.moveHereAction
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
    
    func moveHere(isLeg: Bool) { Task { do {
        let isWing = moveText.count < 4
        let text = try await moveHereAction(isLeg, isWing)
        moveText = text
    } catch {
        moveText = error.localizedDescription
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


