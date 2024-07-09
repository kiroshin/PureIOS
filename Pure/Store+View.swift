//
//  View+OnReceive.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import SwiftUI
import Combine

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    @inlinable public func mxReceive<P>(_ publisher: P, perform action: @escaping (P.Output) -> Void) -> some View where P : Publisher, P.Failure == Never {
        return onReceive(publisher.receive(on: DispatchQueue.main), perform: action)
    }  // unlimited demand
}

