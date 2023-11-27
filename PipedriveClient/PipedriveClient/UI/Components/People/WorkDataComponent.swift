//
//  WorkDataComponent.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import SwiftUI

struct WorkDataComponent: View {
    private let iconSize: CGFloat = 50
    var personalData: Person
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 30) {
                    GridRow {
                        InitialsCircleComponent(fullName: personalData.fullName)
                            .gridColumnAlignment(.center)

                        Text(personalData.fullName)
                            .font(.body)
                    }
                    if (!personalData.companyName.isEmpty){
                        GridRow {
                            Image(systemName: "building.2")
                                .imageScale(.large)
                                .foregroundColor(Color(.mainText2))
                            
                            Text(personalData.companyName)
                                .font(.callout)
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                Spacer()
            }            
        }
        .padding(.leading, 30)
        .background(Color(.mainBackground1))
    }
}

#if DEBUG
struct WorkDataComponent_Previews: PreviewProvider {
    static var previews: some View {
        WorkDataComponent(personalData: Person(name: "Artur Viskoz", firstName: "Artur", lastName: "Viskoz", companyName: "Some company", phone: "55555555", email: "artur.viskoz@test.com"))
    }
}
#endif
