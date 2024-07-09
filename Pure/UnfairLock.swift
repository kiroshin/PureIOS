//
//  UnfairLock.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//

import Foundation

typealias UnfairLock = UnsafeMutablePointer<os_unfair_lock>


extension UnfairLock {
    static func create() -> UnfairLock {
        let lock = UnfairLock.allocate(capacity: 1)
        lock.initialize(to: .init())
        return lock
    }

    static func decreate(_ lock: UnfairLock) {
        lock.deinitialize(count: 1)
        lock.deallocate()
    }
    
    func lock() {
        os_unfair_lock_lock(self)
    }
    
    func unlock() {
        os_unfair_lock_unlock(self)
    }
}


