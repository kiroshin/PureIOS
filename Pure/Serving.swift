//
//  Serving.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
   

import Foundation


protocol Serving {
    var appState: AppState { get }
    var loadPersonAction: LoadPersonUsecase { get }
    var ApplyRegionVisibleAction: ApplyRegionVisibleUsecase { get }
}

typealias LoadPersonUsecase = (Person.ID) async throws -> Person
typealias ApplyRegionVisibleUsecase = (Bool) async -> Void

