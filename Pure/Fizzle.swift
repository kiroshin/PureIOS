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
        case .unknown: return "An unknown error has occurred."
        case .noInternet: return "Check Your Internet Connection."
        case .webGetFail: return "Cannot download data from our server."
        case .dbReadError: return "Cannot read the item."
        case let .invalidURL(url): return "The URL is invalid : \(url)"
        case .walkFail: return "Cannot walk."
        case .notFly: return "NotFly."
    } }
}

