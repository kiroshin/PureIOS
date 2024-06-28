//
//  Vessel.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import Foundation
import Combine

final class Vessel: MutableStore<Roger>, Serving {
    var appState: AppState { toStore() }
    let personDBWork: PersonDBWork = PersonDBRepository()
    lazy var personWebWork: PersonWebWork = PersonWebRepository()
    
    init() {
        super.init(Roger())
        loadQuery()
    }
}

private extension Vessel {
    /// 앱 초기 구동 시, 메타 데이터가 비어있으면 다운받아서 저장한 뒤 로드한다.
    func loadQuery() { Task { do {
        let appStorage = UserDefaults.standard
        if appStorage.sysLaunchedEpochSec == 0 {
            let persons = try await personWebWork.getAllPerson()
            try await personDBWork.updateManyPerson(persons)
            appStorage.sysLaunchedEpochSec = Date.nowEpochSec()
        }
        let metas = try await personDBWork.readAllPersonMeta()
        self.update {
            $0.query.metas = metas
            $0.sys.last = .success
        }
    } catch {
        self.update { $0.sys.last = .failure }
    } } }
}

private extension UserDefaults {
    var sysLaunchedEpochSec: Int {
        get { return self.integer(forKey: "SYS_LAUNCHED_EPOCH_SEC") }
        set { self.set(newValue, forKey: "SYS_LAUNCHED_EPOCH_SEC") }
    }
}

private extension Date {
    static func nowEpochSec() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
}


#if DEBUG
final class Raft: Serving, @unchecked Sendable {
    private let state = CurrentValueSubject<Roger, Never>(Roger(
        sys: .init(last: .success),
        query: .init(metas: [.init(id: "ONE", name: "Jane", age: 19, country: "KO"),
                             .init(id: "TWO", name: "Mark", age: 20, country: "JP"),
                             .init(id: "THR", name: "Tom", age: 45, country: "JP"),
                             .init(id: "FOU", name: "Leo", age: 35, country: "US")])
    ) )
    static let shared = Raft()
    private init() { }
    
    var appState: AppState { state.toStore() }
    
    var loadPersonAction: LoadPersonUsecase { return { idnt in
        if idnt == "" { throw Fizzle.unknown }
        return Person(id: "ONE", name: "Jane", username: "jj", gender: .female, email: "j@a.com", age: 19, country: "KO")
    } }
    
    var applyRegionAction: ApplyRegionUsecase { return { isRegion in
        var current = self.state.value
        current.field.isRegion = isRegion
        self.state.send(current)
    } }
    
    var moveHereAction: MoveHereUsecase { return { (isLeg, isWing) in
        return "HelloWorld"
    } }
}
#endif
