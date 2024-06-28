//
//  MoveAction.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import Foundation

extension Vessel {
    var moveHereAction: MoveHereUsecase {
        let personWebWork = self.personWebWork
        return { (isLeg, isWing) in
            let txtweb = try await personWebWork.walk(isLeg: isLeg)
            let texdb = try await self.personDBWork.fly(isWing: isWing)
            return txtweb + texdb
        }
    }
    
    private func setFieldVisible(isRegion: Bool) async -> Void {
        self.update { $0.field.isRegion = isRegion }
    }
}
