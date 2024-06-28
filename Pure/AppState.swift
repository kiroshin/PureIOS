//
//  AppState.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//


import Foundation

typealias AppState = Store<Roger>

struct Roger: Equatable {
    var sys: Sys = Sys()
    var route: Route = Route()
    var query: Query = Query()
    var field: Field = Field()
}

extension Roger {
    struct Sys: Equatable {
        var last: Signal = .ready
    }

    struct Route: Equatable {
        var uis: Person.ID = ""
    }

    struct Query: Equatable {
        var metas: [Person.Meta] = []
    }

    struct Field: Equatable {
        var isUsername: Bool = true
        var isRegion: Bool = true
    }
    
    enum Signal: Int {
        case failure = -1
        case ready = 0
        case success = 1
    }
}
