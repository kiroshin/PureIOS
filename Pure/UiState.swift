//
//  UiState.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//

import Foundation

@frozen public enum UiState<T> {
    case ready
    case loading(_ permil: Int)
    case success(_ value: T)
    case failure(_ message: String)
}

extension UiState: Equatable where T: Equatable {
    static public func == (lhs: UiState<T>, rhs: UiState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.ready, .ready): return true
        case let (.loading(lhs), .loading(rhs)): return lhs == rhs
        case let (.success(lhs), .success(rhs)): return lhs == rhs
        case let (.failure(lhs), .failure(rhs)): return lhs == rhs
        default: return false
        }
    }
}

extension UiState {
    @inlinable public func onReady(action: () -> Void) {
        if case .ready = self { action() }
    }
    
    @inlinable public func onLoading(action: (Int) -> Void) {
        if case .loading(let permil) = self { action(permil) }
    }
    
    @inlinable public func onSuccess(action: (T) -> Void) {
        if case .success(let value) = self { action(value) }
    }
    
    @inlinable public func onFailure(action: (String) -> Void) {
        if case .failure(let message) = self { action(message) }
    }
    
    @inlinable public func onReadyOrLoading(action: (Int) -> Void) {
        if case .ready = self { action(0) }
        if case .loading(let permil) = self { action(permil) }
    }
}


