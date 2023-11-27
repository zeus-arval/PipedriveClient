//
//  ContentView.swift
//  PipedriveClient
//
//  Created by Артур Валдна on 23.11.2023.
//

import SwiftUI

struct ContentView: View {
    private let container: DIContainer
    
    var body: some View {
        PeopleListScreen()
            .inject(container)
    }
    
    init(container: DIContainer) {
        self.container = container
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}
#endif
