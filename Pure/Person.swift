//
//  Person.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//

import Foundation

struct Person: Identifiable {
    let id: String
    var name: String
    var username: String
    var gender: Gender
    var email: String
    var age: Int
    var country: String
    var cellphone: String?
    var photo: String?
}

extension Person {
    func toMeta() -> Meta {
        return Meta(id: id, name: name, country: country)
    }
    
    struct Meta: Equatable {
        let id: ID
        let name: String
        let country: String
    }
}

enum Gender: String {
    case unknown
    case male
    case female
    
    init(rawValue: String) {
        switch rawValue {
        case "male": self = .male
        case "female": self = .female
        default: self = .unknown
        }
    }
}



