//
//  CoreDataHelpers.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 26.11.2023.
//

import CoreData
import Combine

protocol ManagedEntity where Self: NSFetchRequestResult{
}

extension ManagedEntity where Self: NSManagedObject{
    static var entityName: String {
        let nameMO = String(describing: Self.self)
        let suffixIndex = nameMO.index(nameMO.endIndex, offsetBy: -13)
        return String(nameMO[..<suffixIndex])
    }
    
    static func insertNew(in context: NSManagedObjectContext) -> Self? {
        return NSEntityDescription
            .insertNewObject(forEntityName: entityName, into: context) as? Self
    }
    
    static func makeFetchRequest() -> NSFetchRequest<Self>{
        let name = entityName
        return .init(entityName: name)
    }
}

extension NSManagedObjectContext{
    func configureAsReadOnlyContext() {
        automaticallyMergesChangesFromParent = true
        mergePolicy = NSRollbackMergePolicy
        undoManager = nil
        shouldDeleteInaccessibleFaults = true
    }
    
    func configureAsUpdateContext() {
        mergePolicy = NSOverwriteMergePolicy
        undoManager = nil
    }
}
