//
//  NetworkingHelpers.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 26.11.2023.
//

import Foundation
import Combine

extension Publisher{
    func extractUnderlyingError() -> Publishers.MapError<Self, Failure>{
        mapError{
            ($0.underlyingError as? Failure) ?? $0
        }
    }
    
    func sinkToLoadable(_ completion: @escaping (Loadable<Output>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { subscriptionCompletion in
            if let error = subscriptionCompletion.error {
                completion(.failed(error))
            }
        }, receiveValue: { value in
            completion(.loaded(value))
        })
    }
    
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
            default: break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
}

extension Subscribers.Completion {
    var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}

extension Error{
    var underlyingError: Error?{
        let nsError = self as NSError
        if nsError.domain == NSURLErrorDomain && nsError.code == -1009{
            // The Internet connection appears to be offline
            return self
        }
        return nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }
}

extension Just where Output == Void{
    static func withErrorType<E>(_ errorType: E.Type) -> AnyPublisher<Void, E>{
        withErrorType((), E.self)
    }
}

extension Just {
    static func withErrorType<E>(_ value: Output, _ errorType: E.Type) -> AnyPublisher<Output, E>{
        return Just(value)
            .setFailureType(to: E.self)
            .eraseToAnyPublisher()
    }
}
