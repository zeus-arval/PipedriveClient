//
//  Localizer.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import Foundation

let StringsLocalizer = Localizer()

struct Localizer{
    // People list
    let peopleListTitle = NSLocalizedString("people.list.title", comment: "People")
    
    // Person details
    let personDetailsContactDetailsHeader = NSLocalizedString("person.details.contact.details.header", comment: "Contact Details")
    let personDetailsContactDetailsBodyPhone = NSLocalizedString("person.details.contact.details.body.phone", comment: "phone")
    let personDetailsContactDetailsBodyEmail = NSLocalizedString("person.details.contact.details.body.email", comment: "email")
    let personDetailsTitle = NSLocalizedString("person.details.title", comment: "Person")
    
    fileprivate init(){
    }
}
