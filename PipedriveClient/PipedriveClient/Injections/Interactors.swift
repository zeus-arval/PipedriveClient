//
//  Interactors.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 26.11.2023.
//

import Foundation

extension DIContainer{
    struct Interactors{
        let peopleInteractor: PeopleInteractor
        
        init(peopleInteractor: PeopleInteractor) {
            self.peopleInteractor = peopleInteractor
        }
        
        static var stub: Self {
            .init(peopleInteractor: StubPeopleInteractor())
        }
    }
}
