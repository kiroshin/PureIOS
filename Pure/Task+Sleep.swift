//
//  Task+Sleep.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    public static func mxSleep(sec duration: Int) async throws {
        return try await sleep(nanoseconds: UInt64(duration) * NSEC_PER_SEC)
    }
}

