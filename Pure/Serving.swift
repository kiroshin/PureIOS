//
//  Serving.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
   

import Foundation


protocol Serving {
    var appState: AppState { get }
    var loadPersonAction: LoadPersonUsecase { get }
    var applyRegionAction: ApplyRegionUsecase { get }
    var moveHereAction: MoveHereUsecase { get }
}

typealias LoadPersonUsecase = (Person.ID) async throws -> Person
typealias ApplyRegionUsecase = (Bool) async -> Void
typealias MoveHereUsecase = (Bool, Bool) async throws -> String

