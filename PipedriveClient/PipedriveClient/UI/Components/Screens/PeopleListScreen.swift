//
//  PeopleList.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 23.11.2023.
//

import SwiftUI

struct PeopleListScreen: View {
    @State private(set) var peopleList: Loadable<LazyList<Person>>
    @Environment(\.injected) private var injected: DIContainer
    
    init(peopleList: Loadable<LazyList<Person>> = .notRequested){
        self._peopleList = .init(initialValue: peopleList)
    }
    
    var body: some View {
        VStack(spacing: 0){
            content
        }
    }
    
    @ViewBuilder private var content: some View{
        switch peopleList {
        case let .isLoading(last, _):
            loadingView(last)
        case let .loaded(people):
            loadedView(people)
        case let .failed(error):
            failedView(error)
        case .notRequested:
            notRequestedView
        }
    }

}

#if DEBUG
struct PeopleList_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListScreen(peopleList: .loaded(Person.mockedData.lazyList))
    }
}
#endif


private extension PeopleListScreen {
    func reloadPeople() {
        injected.interactors.peopleInteractor.load(people: $peopleList)
    }
}

private extension PeopleListScreen{
    var notRequestedView: some View{
        Text("").onAppear(perform: reloadPeople)
    }

    func loadingView(_ previouslyLoaded: LazyList<Person>?) -> some View {
        if let people = previouslyLoaded {
            return AnyView(loadedView(people))
        } else {
            return AnyView(ActivityIndicatorView().padding())
        }
    }
    
    func failedView(_ error: Error) -> some View {
        PeopleOrderedListComponent(errorOccured: true)
            .onAppear {
                self.reloadPeople()
            }
    }
    
    func loadedView(_ people: LazyList<Person>) -> some View {
        PeopleOrderedListComponent(people: people, errorOccured: false)
    }}
