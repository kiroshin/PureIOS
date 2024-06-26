//
//  Store.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//

import Foundation
import Combine

typealias Stored<T> = AnyPublisher<T, Never>


protocol StorePublisher<Output, Failure>: Publisher {
    var value: Output { get }
}


struct Store<Output> : StorePublisher, @unchecked Sendable {
    typealias Failure = Never
    
    private let wrapped: any StorePublisher<Output, Never>
    var value: Output { wrapped.value }
    
    init<P>(_ publisher: P) where Output == P.Output, Never == P.Failure, P : StorePublisher {
        self.wrapped = publisher
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Output == S.Input {
        wrapped.receive(subscriber: subscriber)
    }
}


class MutableStore<Output: Equatable>: Publisher, @unchecked Sendable {
    typealias Failure = Never
    
    private let _lock = UnfairLock.create()
    private let _state: CurrentValueSubject<Output, Never>
    
    init(_ value: Output) {
        _state = CurrentValueSubject(value)
    }
    
    deinit {
        UnfairLock.decreate(_lock)
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Output == S.Input {
        _state.receive(subscriber: subscriber)
    }
}
extension MutableStore {
    func update(_ action: @Sendable (inout Output) -> Void) -> Void {
        _lock.lock()
        var value = _state.value
        action(&value)
        if _state.value != value {
            _state.send(value)
        }
        _lock.unlock()
    }
}
extension MutableStore: StorePublisher {
    var value: Output { return _state.value }
    
    func toStore() -> Store<Output> {
        return Store(self)
    }
}



