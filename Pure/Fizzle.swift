//
//  Fizzle.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//


import Foundation

enum Fizzle: LocalizedError {
    case unknown
    case noInternet
    case webGetFail
    case dbReadError
    case invalidURL(url: String)
    case walkFail
    case notFly
    
    var errorDescription: String? { switch self {
        case .unknown: return "알 수 없는 정말 심각한 문제가 있네요 (ㅜ.ㅜ)"
        case .noInternet: return "인터넷이 끊겼어요.."
        case .webGetFail: return "서버에서 자료를 가져올 수 없네요."
        case .dbReadError: return "데이터베이스에서 자료를 읽을 수 없어요."
        case let .invalidURL(url): return "유효하지 않은 주소네요: \(url)"
        case .walkFail: return "걷기 실패"
        case .notFly: return "못날어"
    } }
}

