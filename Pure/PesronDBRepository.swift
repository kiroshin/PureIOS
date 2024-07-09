//
//  PesronDBRepository.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import Foundation
import CoreData

final class PersonDBRepository: CoreDataStacking {
    private static let sharedPersistence = NSPersistentContainer(store: "Pure")
    var container: NSPersistentContainer { PersonDBRepository.sharedPersistence }
}

extension PersonDBRepository: PersonDBWork {
    func readAllPersonMeta() async throws -> [Person.Meta] { try await context.perform { do {
        let models = try self.readAll(sortKey: \HumanMO.idnt)
        return models.map { $0.toMeta() }
    } catch {
        throw Fizzle.dbReadError
    } } }
    
    func readPerson(id: Person.ID) async throws -> Person { try await context.perform { do {
        let predicate = NSPredicate(format: "%K = %@", #keyPath(HumanMO.idnt), id)
        let result = try self.readFirst("Human", pred: predicate)
        let model = result as! HumanMO
        return model.toEntity()
    } catch {
        throw Fizzle.dbReadError
    } } }
    
    func updateManyPerson(_ persons: [Person]) async throws {
        await context.perform {
            persons.forEach {
                let model = self.create("Human") as! HumanMO
                model.apply($0)
            }
            self.saveContext()
        }
    }
    
    func fly(isWing: Bool) async throws -> String {
        if isWing { return "WING" }
        throw Fizzle.notFly
    }
}
