//
//  UiState.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//

import Foundation


@frozen enum UiState<T> {
    case ready
    case loading(_ permil: Int)
    case success(_ value: T)
    case failure(_ message: String)
}

extension UiState: Equatable where T: Equatable {
    static func == (lhs: UiState<T>, rhs: UiState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.ready, .ready): return true
        case let (.loading(lhs), .loading(rhs)): return lhs == rhs
        case let (.success(lhs), .success(rhs)): return lhs == rhs
        case let (.failure(lhs), .failure(rhs)): return lhs == rhs
        default: return false
        }
    }
}


