//
//  CancellableSet.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 26.11.2023.
//

import Combine

final class CancellableSet{
    fileprivate(set) var subscriptions = Set<AnyCancellable>()
    private let equalToAny: Bool
    
    init(equalToAny: Bool = false) {
        self.equalToAny = equalToAny
    }
    
    func cancel(){
        subscriptions.removeAll()
    }
    
    func isEqual(to other: CancellableSet) -> Bool {
        return other === self || other.equalToAny || self.equalToAny
    }
}

extension AnyCancellable {
    func store(in set: CancellableSet){
        set.subscriptions.insert(self)
    }
}
