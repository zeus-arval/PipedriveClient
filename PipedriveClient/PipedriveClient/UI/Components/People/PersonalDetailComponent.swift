//
//  ContactDetailComponent.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import SwiftUI

struct PersonalDetailComponent: View {
    var contactDetail: Person.PersonalDetail
    
    var body: some View {
        VStack(spacing: 0){
            VStack(alignment:.leading){
                HStack{
                    Text(contactDetail.key.capitalized)
                        .font(.caption)
                        .foregroundColor(Color(.mainText2))
                    Spacer()
                }
                HStack{
                    Text(contactDetail.value)
                    Spacer()
                }
            }
            .padding(20)
            .padding(.leading, 10)
            .background(Color(.mainBackground1))
            
            Divider()
                .background(Color(.mainText2))
        }
    }
}

#if DEBUG
struct ContactDetailComponent_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDetailComponent(contactDetail: Person.PersonalDetail(key: "phone", value: "+37255858855"))
    }
}
#endif
