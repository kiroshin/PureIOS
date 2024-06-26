//
//  HumanMO+CoreDataClass.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//


import Foundation
import CoreData

@objc(HumanMO)
public class HumanMO: NSManagedObject {

}

extension HumanMO {
    func apply(_ entity: Person) {
        idnt = entity.id
        name = entity.name
        username = entity.username
        gender = entity.gender.rawValue
        email = entity.email
        age = Int16(entity.age)
        country = entity.country
        cellphone = entity.cellphone
        photo = entity.photo
    }
    
    func toEntity() -> Person {
        return Person(id: idnt!,
                      name: name!,
                      username: username!,
                      gender: Gender(rawValue: gender!),
                      email: email!,
                      age: Int(age),
                      country: country!,
                      cellphone: cellphone,
                      photo: photo)
    }
    
    func toMeta() -> Person.Meta {
        return Person.Meta(id: idnt!, name: name!, country: country!)
    }
}
