//
//  PersonRow.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import SwiftUI

struct PersonRowComponent: View {
    @State var personalData: Person
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(personalData.firstName).fontWeight(.bold)
                Text(personalData.lastName).fontWeight(.regular)
            }
            .font(.title3)
            
            Text(personalData.companyName)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.bottom, 2)
        .padding(.top, 3)
    }
}

#if DEBUG
struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        PersonRowComponent(personalData: Person(name: "Artur Viskoz", firstName: "Artur", lastName: "Viskoz", companyName: "Some company", phone: "55555555", email: "artur.viskoz@test.com"))
    }
}
#endif
