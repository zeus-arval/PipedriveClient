//
//  PeopleWebRepository.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import Foundation
import Combine

protocol PeopleWebRepository: WebRepository{
    func loadPeople() -> AnyPublisher<[Person], Error>
}

struct RealPeopleWebRepository: PeopleWebRepository {
    let session: URLSession
    let baseURL: String
    let dispatchQueue: DispatchQueue = DispatchQueue(label: "background_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadPeople() -> AnyPublisher<[Person], Error>{
        return call(endpoint: API.allPeople)
    }
    
    func map<Value>(data: Data) -> Value {
        PersonMapper.map(data: data) as! Value
    }
}

extension RealPeopleWebRepository {
    enum API{
        case allPeople
    }
}

extension RealPeopleWebRepository.API: APICallMetadata {
    var path: String {
        switch self {
        case .allPeople:
            return "/persons/list?user_id=\(getUserId())&api_token=\(getToken())"
        }
    }
    
    var method: String {
        switch self {
        case .allPeople:
            return "GET"
        }
    }
        
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
        
    func body() throws -> Data? {
        return nil
    }
}
