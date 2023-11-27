//
//  PipedriveClientApp.swift
//  PipedriveClient
//
//  Created by Артур Валдна on 23.11.2023.
//

import SwiftUI

@main
struct PipedriveClientApp: App {
    private let appEnvironment: AppEnvironment
      
    var body: some Scene {
        WindowGroup {
            ContentView(container: appEnvironment.container)
        }
    }
    
    init() {
        appEnvironment = AppEnvironment.bootstrap()
    }
}
