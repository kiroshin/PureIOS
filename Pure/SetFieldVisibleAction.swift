//
//  SetFieldVisibleAction.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import Foundation

extension Vessel {
    var ApplyRegionVisibleAction: ApplyRegionVisibleUsecase { return setFieldVisible }
    
    private func setFieldVisible(isRegion: Bool) async -> Void {
        self.update { $0.field.isRegion = isRegion }
    }
}

