//
//  WebRepository.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import Foundation
import Combine
import SwiftyJSON

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var dispatchQueue: DispatchQueue { get }
    
    func map<Value>(data: Data) -> Value
}

extension WebRepository {
    func call<Value>(endpoint: APICallMetadata, httpCodes: HTTPCodes = .success) -> AnyPublisher<Value, Error>
    where Value : Decodable {
        do {
            let request = try endpoint.makeURLRequest(baseUrl: baseURL)
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpCodes: httpCodes, map: map)
        } catch {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

// MARK: Helpers

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestData(httpCodes: HTTPCodes = .success) -> AnyPublisher<Data, Error> {
        return tryMap {
            assert(!Thread.isMainThread)
            guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                throw APIError.unexpectedResponse
            }
            guard httpCodes.contains(code) else {
                throw APIError.httpCode(code)
            }
            
            return $0.0
        }
        .extractUnderlyingError()
        .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output{
    func requestJSON<Value>(httpCodes: HTTPCodes, map: @escaping (Data) -> Value) -> AnyPublisher<Value, Error> where Value: Decodable{
        return requestData(httpCodes: httpCodes)
            .tryMap({ data in
                map(data)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
