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
        var last: Signal = .ready               // 초기 데이터 로드 여부
        var count: Int = 0                      // 컨트롤 버튼 누른 횟수
    }

    struct Route: Equatable {
        var uis: String = ""                    // 마지막 선택 유저 ID
    }

    struct Query: Equatable {
        var metas: [Person.Meta] = []           // 로드한 메타 데이타
    }

    struct Field: Equatable {
        var isUsername: Bool = true             // 유저네임 필드 보일지 여부
        var isRegion: Bool = true               // 지역 보일지 여부
    }
    
    enum Signal: Int {
        case failure = -1
        case ready = 0
        case success = 1
    }
}
