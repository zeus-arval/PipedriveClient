//
//  LoadableObject.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 26.11.2023.
//

import Foundation
import SwiftUI

typealias LoadableObject<Value> = Binding<Loadable<Value>>

enum Loadable<T> {
    case notRequested
    case isLoading(last: T?, cancellableSet: CancellableSet)
    case loaded(T)
    case failed(Error)
    
    var value: T?{
        switch self{
        case let .isLoading(last, _): return last
        case let .loaded(value): return value
        default: return nil
        }
    }
    var error: Error?{
        switch self{
        case let .failed(error): return error
        default: return nil
        }
    }
}

extension Loadable{
    mutating func setIsLoading(cancellableSet: CancellableSet){
        self = .isLoading(last: value, cancellableSet: cancellableSet)
    }
    
}
