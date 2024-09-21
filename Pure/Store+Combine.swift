//
//  Store+Combine.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import Foundation
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension StorePublisher where Self.Failure == Never {
    func stored<T: Equatable>(_ transform: @escaping (Output) -> T) -> Stored<T> {
        map(transform).removeDuplicates().eraseToAnyPublisher()
    }
    
    func stored<T: Equatable>(keyPath: KeyPath<Output, T>) -> Stored<T> {
        return map(keyPath).removeDuplicates().eraseToAnyPublisher()
    }
}


@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension CurrentValueSubject: StorePublisher where Failure == Never {
    func asStore() -> Store<Output> {
        return Store(self)
    }
}


@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Publisher where Self.Failure == Never {
    public func give(to published: inout Published<Self.Output>.Publisher) {
        receive(on: DispatchQueue.main).assign(to: &published)
    }
}

