//
//  loadPersonAction.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import Foundation

extension Vessel {
    var loadPersonAction: LoadPersonUsecase { return loadPerson }
    
    private func loadPerson(idnt: Person.ID) async throws -> Person {
        if idnt == "" { throw Fizzle.unknown }
        return try await personDBWork.readPerson(id: idnt)
    }
}

