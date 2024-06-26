//
//  loadPersonAction.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import Foundation

extension Vessel {
    var loadPersonAction: LoadPersonUsecase { return _loadPersonAction }
    
    private func _loadPersonAction(idnt: Person.ID) async throws -> Person {
        if idnt == "" { throw Fizzle.unknown }
        return try await personDBWork.readPerson(id: idnt)
    }
}

