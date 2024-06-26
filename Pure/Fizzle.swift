//
//  Fizzle.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//

import Foundation

enum Fizzle: LocalizedError {
    case unknown
    case webFail
    case dbMetaFail
    case dbItemFail
    case invalidURL(url: String)
    
    var errorDescription: String? {
        switch self {
        case .unknown: return "알 수 없는 문제가 있네요 (ㅜ.ㅜ)"
        case .webFail: return "서버에서 자료를 가져오지 못했어요."
        case .dbMetaFail: return "자료를 읽어올 수 없어요."
        case .dbItemFail: return "해당 인물을 찾을 수 없어요."
        case let .invalidURL(url): return "유효하지 않은 주소네요: \(url)"
    } }
}

