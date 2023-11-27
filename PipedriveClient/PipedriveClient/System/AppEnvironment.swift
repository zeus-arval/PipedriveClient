//
//  AppEnvironment.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import Foundation
import Combine

struct AppEnvironment{
    let container: DIContainer
}

extension AppEnvironment{
    static func bootstrap() -> AppEnvironment{
        let userData = createUserData()
        let appState = Store<AppState>(AppState(userData: userData))
        let session = configuredURLSession()
        let webRepositories = configureWebRepositories(session: session)
        let dbRepositories = configuredDBRepositories(appState: appState)
        let interactors = configuredInteractors(appState: appState, dbRepositories: dbRepositories, webRepositories: webRepositories)
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        
        return AppEnvironment(container: diContainer)
    }
    
    private static func createUserData() -> AppState.UserData {
        return AppState.UserData(peopleList: .isLoading(last: .empty, cancellableSet: .init()))
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    private static func configureWebRepositories(session: URLSession) -> DIContainer.WebRepositories{
        let peopleRepository = RealPeopleWebRepository(
            session: session,
            baseURL: "https://api.pipedrive.com/v1")
        return .init(peopleRepository: peopleRepository)
    }
    
    private static func configuredDBRepositories(appState: Store<AppState>) -> DIContainer.DBRepositories{
        let persistentStore = CoreDataStack(version: CoreDataStack.Version.actual)
        let peopleRepository = RealPeopleDBRepository(persistentStore: persistentStore)
        return .init(peopleRepository: peopleRepository)
    }
    
    
    private static func configuredInteractors(appState: Store<AppState>,
                                              dbRepositories: DIContainer.DBRepositories,
                                              webRepositories: DIContainer.WebRepositories
    ) -> DIContainer.Interactors {
        let peopleInteractor = RealPeopleInteractor(webRepository: webRepositories.peopleRepository, dbRepository: dbRepositories.peopleRepository, appState: appState)
        
        return .init(peopleInteractor: peopleInteractor)
    }
}

extension DIContainer {
    struct WebRepositories {
        let peopleRepository: PeopleWebRepository
    }
    
    struct DBRepositories {
        let peopleRepository: PeopleDBRepository
    }
}
