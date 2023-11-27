//
//  PeopleDBRepository.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 26.11.2023.
//

import Foundation
import Combine
import CoreData

protocol PeopleDBRepository: DBRepository {
    func people() -> AnyPublisher<LazyList<Person>, Error>
    func hasLoadedPeople() -> AnyPublisher<Bool, Error>
    func save(people: [Person]) -> AnyPublisher<Void, Error>
}

struct RealPeopleDBRepository: PeopleDBRepository {
    let persistentStore: PersistentStore
    
    func hasLoadedPeople() -> AnyPublisher<Bool, Error> {
        let fetchRequest = PersonManagedObject.justOnePerson()
        return persistentStore
            .count(fetchRequest)
            .map{ $0 > 0 }
            .eraseToAnyPublisher()
    }
    
    func save(people: [Person]) -> AnyPublisher<Void, Error> {
        return persistentStore
            .update { context in
                people.forEach{
                    $0.store(in: context)
                }
            }
    }
    
    func people() -> AnyPublisher<LazyList<Person>, Error> {
        let fetchRequest = PersonManagedObject.people()
        return persistentStore
            .fetch(fetchRequest) {
                Person(managedObject: $0)
            }
            .eraseToAnyPublisher()
    }
}

extension PersonManagedObject{
    static func justOnePerson() -> NSFetchRequest<PersonManagedObject> {
        let request = makeFetchRequest()
        request.fetchLimit = 1
        return request
    }
    
    static func people() -> NSFetchRequest<PersonManagedObject> {
        let request = makeFetchRequest()
        request.predicate = NSPredicate(value: true)
        request.sortDescriptors = [NSSortDescriptor(key: "firstName", ascending: true)]
        request.fetchBatchSize = 10
        return request
    }
}
