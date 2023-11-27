//
//  RootViewAppearance.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 26.11.2023.
//

import SwiftUI
import Combine

// MARK: - RootViewAppearance

struct RootViewAppearance: ViewModifier {
    @Environment(\.injected) private var injected: DIContainer
    
    func body(content: Content) -> some View{
        content
    }
}
