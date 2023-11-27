//
//  PersonalDetailsHeaderComponent.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import SwiftUI

struct PersonalDetailsHeaderComponent: View {
    var headerText: String
    
    var body: some View {
        HStack{
            Text(headerText.uppercased())
                .font(.body)
                .padding(30)
                .foregroundColor(Color(.mainText2))
            Spacer()
        }
        .background(Color(.mainBackground2))
    }
}

#if DEBUG
struct PersonalDetailsHeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDetailsHeaderComponent(headerText: "Contact Details")
    }
}
#endif
