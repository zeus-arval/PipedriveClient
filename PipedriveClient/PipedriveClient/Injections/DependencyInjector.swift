//
//  DependencyInjector.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import Foundation
import SwiftUI

struct DIContainer: EnvironmentKey {
    let appState: Store<AppState>
    let interactors: Interactors
    
    init(appState: Store<AppState>, interactors: Interactors) {
        self.appState = appState
        self.interactors = interactors
    }
    
    init(appState: AppState, interactors: Interactors) {
        self.init(appState: Store<AppState>(appState), interactors: interactors)
    }
    
    private static let `default` = Self(appState: AppState(userData: AppState.UserData(peopleList: .notRequested)), interactors: .stub)
    static var defaultValue: Self { Self.default }
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(appState: .init(AppState.preview), interactors: .stub)
    }
}
#endif

// MARK: Injections into the view hierarchy

extension View {
    func inject(_ appState: AppState,
                _ interactors: DIContainer.Interactors) -> some View{
        let container = DIContainer(appState: appState, interactors: interactors)
        return inject(container)
    }
    
    func inject(_ container: DIContainer) -> some View{
        return self
            .environment(\.injected, container)
    }
}
