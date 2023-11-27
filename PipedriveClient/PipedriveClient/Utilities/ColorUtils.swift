//
//  ColorUtils.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import Foundation
import SwiftUI

enum ColorEnum: String {
    case mainBackground1 = "Main Background 1"
    case mainBackground2 = "Main Background 2"
    case searchBackground = "Search Background Color"
    case searchText = "Search Text Color"
    case mainText1 = "Main Text Color 1"
    case mainText2 = "Main Text Color 2"
    case smallCircle = "Small Circle Color"
    case bigCircle = "Big Circle Color"
    case image = "Image"
}

extension Color {
    init(_ colorEnum: ColorEnum) {
        self.init(colorEnum.rawValue)
    }
}
