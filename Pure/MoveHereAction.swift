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
            let txtdb = try await self.personDBWork.fly(isWing: isWing)
            return txtweb + txtdb
        }
    }
    
}
