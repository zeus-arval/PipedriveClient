//
//  DBRepository.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 26.11.2023.
//

import Foundation
import Combine

protocol DBRepository{
    func hasLoadedPeople() -> AnyPublisher<Bool, Error>
}
