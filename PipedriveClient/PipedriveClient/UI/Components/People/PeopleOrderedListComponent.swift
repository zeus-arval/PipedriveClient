//
//  PeopleOrderedList.swift
//  PipedriveClientApp
//
//  Created by Артур Валдна on 25.11.2023.
//

import SwiftUI

struct PeopleOrderedListComponent: View {
    @State var people: LazyList<Person>?
    @State var errorOccured: Bool
    @State var errorMessage: String = ""
    
    private var peopleOrderedLists: [OrderedPersonalDataList]{
        people?.mapToOrderedDataLists() ?? []
    }
    
    private var containsPeople: Bool {
        people != nil && !peopleOrderedLists.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading){
            NavigationView{
                if containsPeople{
                    List(peopleOrderedLists){ personalDataList in
                        Section(){
                            ForEach(personalDataList.datas, id: \.self) { data in
                                if data.firstName != ""  {
                                    NavigationLink {
                                        PersonDetailsScreen(personalData: data)
                                    } label: {
                                        PersonRowComponent(personalData: data)
                                    }
                                    .navigationBarTitle("")
                                }
                            }
                        }
                    header: {
                        HStack{
                            Text(personalDataList.firstCharacter)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    }
                    }
                    .listStyle(.grouped)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack{
                                Spacer()
                                Text("People")
                                    .padding(40)
                                    .font(.body)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .background(Color(.mainBackground1))
        }
    }
}

#if DEBUG
struct PeopleOrderedList_Previews: PreviewProvider {
    static var previews: some View {
        PeopleOrderedListComponent(people: Person.mockedData.lazyList, errorOccured: false)
    }
}
#endif

struct OrderedPersonalDataList: Identifiable, Hashable{
    let id: Int
    let firstCharacter: String
    let datas: [Person]
    
    var isEmpty: Bool{
        datas.isEmpty
    }
    
    init(firstCharacter: String, datas: [Person]) {
        self.id = firstCharacter.hashValue
        self.firstCharacter = "\(firstCharacter.uppercased())"
        self.datas = datas
    }
}

fileprivate extension LazyList<Person> {
    func mapToOrderedDataLists() -> [OrderedPersonalDataList]{
        var orderedLists: [OrderedPersonalDataList] = []
        var people: [Person] = []
        var previousChar: String?
        self.forEach { person in
            if (previousChar == nil){
                previousChar = person.firstChar
            } else if (previousChar != person.firstChar){
                orderedLists.append(OrderedPersonalDataList(firstCharacter: previousChar!, datas: people))
                people = []
            }
            
            previousChar = person.firstChar
            people.append(person)
        }
        orderedLists.append(OrderedPersonalDataList(firstCharacter: previousChar!, datas: people))
        return orderedLists
    }
}
