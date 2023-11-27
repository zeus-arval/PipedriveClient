//
//  MockedData.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 26.11.2023.
//

import Foundation

#if DEBUG
extension Person {
    static let mockedData: [Person] = [
        Person(name: "Andres Viskoze", firstName: "Andres", lastName: "Viskoze", companyName: "Metall company OÜ", phone: "+3725959595995", email: "andres.viskoze@test.ee"),
        Person(name: "Arthur Dynaro", firstName: "Arthur", lastName: "Dynaro", companyName: "Some name OÜ", phone: "+37255858555", email: "artur.dynaro@test.ee"),
        Person(name: "Carla Ragni", firstName: "Carla", lastName: "Ragni", companyName: "Ragni company OÜ", phone: "+3725959595995", email: "carla.ragni@test.ee"),
        Person(name: "Claudia Smith", firstName: "Claudia", lastName: "Smith", companyName: "Smith company OÜ", phone: "+37255858555", email: "claudia.smith@test.ee"),
        Person(name: "Cesar Mongoly", firstName: "Cesar", lastName: "Mongoly", companyName: "Mongoly company OÜ", phone: "+37255858555", email: "cesar.mongoly@test.ee")
    ]
}
#endif
