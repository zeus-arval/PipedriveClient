//
//  PersonDetails.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 24.11.2023.
//

import SwiftUI

struct PersonDetailsScreen: View {
    var personalData: Person
    
    var body: some View {
        ScrollView{
            Spacer(minLength: 20)
            VStack(spacing: 0){
                WorkDataComponent(personalData: personalData)
                
                // MARK: Contact Details Section
                VStack(spacing: 0){
                    
                    Divider()
                        .background(Color(.mainText2))

                    ForEach(personalData.personalDetailLists, id: \.self){ personalDetailList in
                        
                        PersonalDetailsHeaderComponent(headerText: personalDetailList.descriptor)
                        
                        Divider()
                            .background(Color(.mainText2))
                        
                        ForEach(personalDetailList.details){ detail in
                            if detail.isNotEmpty{
                                PersonalDetailComponent(contactDetail: detail)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .foregroundColor(Color(.mainText1))
        }
        .navigationTitle(StringsLocalizer.personDetailsTitle)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.mainBackground2))
    }
}

struct PersonalDetailsSection {
    let headerText: String
    let contactDetails: [Person.PersonalDetail]
}

#if DEBUG
struct PersonDetails_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsScreen(personalData: Person(name: "Artur Viskoz", firstName: "Artur", lastName: "Viskoz", companyName: "Some company", phone: "55555555", email: "artur.viskoz@test.com"))
    }
}
#endif
