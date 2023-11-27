//
//  InitialsCircle.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 24.11.2023.
//

import SwiftUI

struct InitialsCircleComponent: View {
    var circleSize: CGFloat = 50
    var fullName: String
    
    var initials: String {
        fullName.split(separator: " ").map({ word in
            word.first?.uppercased() ?? ""
        }).joined()
    }
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color(.smallCircle))
                .frame(maxWidth: circleSize, maxHeight: circleSize)
                .overlay(Text(initials)
                    .foregroundColor(Color(.mainText1))
                    .font(.body)
                )
        }
    }
}

struct InitialsCircle_Previews: PreviewProvider {
    static var previews: some View {
        InitialsCircleComponent(fullName: "Andres Viskoze")
    }
}
