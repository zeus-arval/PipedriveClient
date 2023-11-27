//
//  AppState.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import Foundation
import SwiftUI
import Combine

struct AppState {
    var userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
    }
}

extension AppState{
    struct UserData {
        var peopleList: Loadable<LazyList<Person>>
    }
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        return AppState(userData: UserData(peopleList: .notRequested))
    }
}
#endif
