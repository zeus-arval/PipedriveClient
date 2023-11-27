//
//  Person.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 24.11.2023.
//

import Foundation
import SwiftyJSON

struct Person: Codable, Hashable {
    let name: String
    let firstName: String
    let lastName: String
    let companyName: String
    let phone: String
    let email: String
    
    init(name: String, firstName: String, lastName: String, companyName: String, phone: String, email: String) {
        self.name = name
        self.firstName = firstName
        self.lastName = lastName
        self.companyName = companyName
        self.phone = phone
        self.email = email
    }
}

extension Person{
    
    var firstChar: String {
        "\(firstName.first!)"
    }
    
    var fullName: String {
        firstName != "" || lastName != "" ? "\([firstName, lastName].joined(separator: " "))" : ""
    }
    private var contactDetailsList: [Person.PersonalDetail]{
        var detailList: [Person.PersonalDetail] = []
        
        if !email.isEmpty{
            detailList.append(Person.PersonalDetail(key: StringsLocalizer.personDetailsContactDetailsBodyEmail, value: email))
        }
        
        if !phone.isEmpty{
            detailList.append(Person.PersonalDetail(key: StringsLocalizer.personDetailsContactDetailsBodyPhone, value: phone))
        }

        return detailList
    }
    
    var personalDetailLists: [Person.PersonalDetailList]{
        var detailLists: [Person.PersonalDetailList] = []
        
        if (!contactDetailsList.isEmpty){
            detailLists.append(Person.PersonalDetailList(descriptor: StringsLocalizer.personDetailsContactDetailsHeader, details: contactDetailsList))
        }
        
        return detailLists
    }
}

extension Person{
    struct PersonalDetail: Identifiable, Hashable{
        let id: UUID
        let key: String
        let value: String
        
        var isNotEmpty: Bool{
            !key.isEmpty && !value.isEmpty
        }
        init(id: UUID = UUID(), key: String, value: String) {
            self.id = id
            self.key = key
            self.value = value
        }
    }
    
    struct PersonalDetailList: Hashable, Identifiable {
        let id: UUID
        let descriptor: String
        let details: [Person.PersonalDetail]
        
        init(id: UUID = UUID(), descriptor: String, details: [Person.PersonalDetail]) {
            self.id = id
            self.descriptor = descriptor
            self.details = details
        }
    }
}

struct PersonMapper{
    static func map(data: Data) -> [Person] {
        var people: [Person] = []
        
        if let json = try? JSON(data: data){
            guard json["success"].bool ?? false else {
                return people
            }
            
            for item in json["data"].arrayValue{
               let name = item["name"].string ?? ""
               let firstName = item["first_name"].string ?? ""
               let lastName = item["last_name"].string ?? ""
               let companyName = item["company_name"].string ?? ""
               let email = item["email"][0]["value"].string ?? ""
               let phone = item["phone"][0]["value"].string ?? ""

               people.append(Person(name: name, firstName: firstName, lastName: lastName, companyName: companyName, phone: phone, email: email))
            }
        }
        
        return people
    }
}
