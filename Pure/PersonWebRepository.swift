//
//  PersonWebRepository.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import Foundation


final class PersonWebRepository: PersonWebWork {
    let access = HTTPRandomuserAccess()
    
    func getAllPerson() async throws -> [Person] { do {
        let raw = try await access.getAllUser(100, retry: 3)
        return raw.map { $0.toEntity() }
    } catch {
        print("**** ERROR LOGGING: \(error.localizedDescription)")
        throw Fizzle.webGetFail
    } }
    
    func walk(isLeg: Bool) async throws -> String {
        if isLeg { return "LEG" }
        throw Fizzle.walkFail
    }
}


private extension HTTPRandomuserAccess.User {
    func toEntity() -> Person {
        return Person(id: login.uuid!,
                      name: "\(name.first ?? "") \(name.last ?? "")".trimmingCharacters(in: .whitespaces),
                      username: login.username ?? "",
                      gender: Gender(rawValue: gender ?? ""),
                      email: email ?? "",
                      age: dob.age ?? 0,
                      country: nat ?? "ZZ",
                      cellphone: cell,
                      photo: picture.large)
    }
}
