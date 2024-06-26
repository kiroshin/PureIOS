//
//  Working.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import Foundation

protocol PersonWebWork {
    func getAllPerson() async throws -> [Person]
}

protocol PersonDBWork {
    func readAllPersonMeta() async throws -> [Person.Meta]
    func readPerson(id: Person.ID) async throws -> Person
    func updateManyPerson(_ persons: [Person]) async throws
}

