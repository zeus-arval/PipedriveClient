//
//  PeopleInteractor.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 26.11.2023.
//

import Combine
import Foundation
import SwiftUI

protocol PeopleInteractor{
    func refreshPeopleList() -> AnyPublisher<Void, Error>
    func load(people: LoadableObject<LazyList<Person>>)
}

struct RealPeopleInteractor: PeopleInteractor{
    let webRepository: PeopleWebRepository
    let dbRepository: PeopleDBRepository
    let appState: Store<AppState>
    
    init(webRepository: PeopleWebRepository, dbRepository: PeopleDBRepository, appState: Store<AppState>) {
        self.webRepository = webRepository
        self.dbRepository = dbRepository
        self.appState = appState
    }
    
    func refreshPeopleList() -> AnyPublisher<Void, Error> {
        return webRepository
            .loadPeople()
            .flatMap{ [dbRepository] in
                dbRepository.save(people: $0)
            }
            .eraseToAnyPublisher()
    }
    
    func load(people: LoadableObject<LazyList<Person>>) {
        let cancellableSet = CancellableSet()
        people.wrappedValue.setIsLoading(cancellableSet: cancellableSet)
        
        Just<Void>
            .withErrorType(Error.self)
            .flatMap { _ in
                dbRepository.hasLoadedPeople()
            }
            .flatMap { hasLoaded -> AnyPublisher<Void, Error> in
                if hasLoaded {
                    return Just<Void>.withErrorType(Error.self)
                } else {
                    return self.refreshPeopleList()
                }
            }
            .flatMap { [dbRepository] in
                dbRepository.people()
            }
            .sinkToLoadable {
                people.wrappedValue = $0
            }
            .store(in: cancellableSet)
    }
}

struct StubPeopleInteractor: PeopleInteractor{
    func refreshPeopleList() -> AnyPublisher<Void, Error> {
        return Just<Void>.withErrorType(Error.self)
    }
    
    func load(people: LoadableObject<LazyList<Person>>) {
    }
}
