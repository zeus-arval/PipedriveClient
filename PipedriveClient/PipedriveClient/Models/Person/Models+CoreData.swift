//
//  Models+CoreData.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 26.11.2023.
//

import Foundation
import CoreData

extension PersonManagedObject: ManagedEntity {
}

extension Person{
    @discardableResult
    func store(in context: NSManagedObjectContext) -> PersonManagedObject? {
        guard let person = PersonManagedObject.insertNew(in: context) else {
            return nil
        }
        person.firstName = firstName
        person.lastName = lastName
        person.companyName = companyName
        person.email = email
        person.phone = phone
        person.name = name
        return person
    }
    
    init?(managedObject: PersonManagedObject){
        guard let name = managedObject.name,
              let firstName = managedObject.firstName,
              let lastName = managedObject.lastName,
              let companyName = managedObject.companyName,
              let email = managedObject.email,
              let phone = managedObject.phone else{
              return nil
          }
        self.init(name: name, firstName: firstName, lastName: lastName, companyName: companyName, phone: phone, email: email)
    }
}
