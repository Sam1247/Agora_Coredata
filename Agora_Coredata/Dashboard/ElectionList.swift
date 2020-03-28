//
//  ElectionList.swift
//  Agora_Coredata
//
//  Created by Abdalla Elsaman on 3/23/20.
//  Copyright © 2020 Dumbies. All rights reserved.
//

import SwiftUI
import CoreData

struct ElectionList: View {
    
    let header: ElectionListHeader
    
    var fetchRequest: FetchRequest<Election>
    init(for kind: FetchRequestKind, header: ElectionListHeader) {
        switch kind {
        case .all:
            fetchRequest = FetchRequest<Election>(entity: Election.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Election.name, ascending: true)])
        case .active:
            fetchRequest = FetchRequest<Election>(entity: Election.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Election.name, ascending: true)],predicate: NSPredicate(format: "endDate > %@ AND startDate < %@", NSDate(), NSDate()))
        case .finihed:
            fetchRequest = FetchRequest<Election>(entity: Election.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Election.name, ascending: true)],
            predicate: NSPredicate(format: "endDate < %@", NSDate()))
        case .pending:
            fetchRequest = FetchRequest<Election>(entity: Election.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Election.name, ascending: true)],
            predicate: NSPredicate(format: "startDate > %@", NSDate()))
        }
        self.header = header
    }
    
    var body: some View {
        List {
            Section (header: header) {
                ForEach(fetchRequest.wrappedValue, id: \.uid) { election in
                    //let electionModel = getElectionModel(from: election)
                    NavigationLink(destination: ElectionDetail(election: election)) {
                        AbstractCell(labelname: election.name ?? "Election Name", color: Color.init(.systemGreen), systemNameIcon: "person.2.fill")
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("Elections", displayMode: .inline)
    }
}

struct ElectionListHeader: View {
    let label: String
    let color: Color
    let iconSystemName: String
    var body: some View {
        HStack (alignment: .center){
            Text(label)
                .font(.system(size: 24))
                .bold()
                .foregroundColor(Color.init(.label))
            
            Image(systemName: iconSystemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
                .foregroundColor(color)
            
        }.padding(.top)
    }
}


