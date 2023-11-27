//
//  APICallMetadata.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import Foundation

protocol APICallMetadata {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

enum APIError: Swift.Error {
    case invalidUrl
    case httpCode(HTTPCode)
    case unexpectedResponse
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        }
    }
}

extension APICallMetadata{
    func makeURLRequest(baseUrl: String) throws -> URLRequest{
        guard let url = URL(string: baseUrl + path) else{
            throw APIError.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
    
    func getToken() -> String {
        ApiMetaStorage.token
    }
    
    func getUserId() -> String {
        ApiMetaStorage.userId
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}

fileprivate extension ApiMetaStorage {
    static let token: String = "INSERT YOUR TOKEN"
    static let userId: String = "INSERT YOUR USERID"
}
