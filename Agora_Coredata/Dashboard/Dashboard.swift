//
//  ContentView.swift
//  Agora_Coredata
//
//  Created by Abdalla Elsaman on 3/22/20.
//  Copyright © 2020 Dumbies. All rights reserved.
//

import SwiftUI

struct Dashboard: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Election.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Election.name, ascending: true),
        ]
        //,
        //predicate: NSPredicate(format: "endDate > %@ AND startDate < %@", NSDate(), NSDate())
    ) var activeFetchedElections: FetchedResults<Election>

    @ObservedObject var electionDataCreating: ElectionDataCreating = ElectionDataCreating()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: UpperView()) {
                    EmptyView()
                }
                
                Section(header: ActiveHeader()) {
                    ForEach(activeFetchedElections, id: \.uid) { election in
                        //let electionModel = getElectionModel(from: election)
                        NavigationLink(destination: ElectionDetail(election: election)) {
                            AbstractCell(labelname: election.name ?? "Election Name", color: Color.init(.systemGreen), systemNameIcon: "person.2.fill")
                        }
                    }.onDelete(perform: removeElection)
                }
                
                Section (header: CreateElectionButton(electionDataCreating: $electionDataCreating.data)) {
                    EmptyView()
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Dashboard")
            .environment(\.horizontalSizeClass, .regular)
        }
    }
    
    func removeElection(at offsets: IndexSet) {
        for index in offsets {
            let election = activeFetchedElections[index]
            managedObjectContext.delete(election)
        }
    }
}

struct CreateElectionButton: View {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var electionDataCreating: ElectionModel
    @State var showingCreateElection = false

    var body: some View {
        Button(action: {
            self.showingCreateElection.toggle()
        }) {
            AbstractButtonView(color: Color.init(.systemGreen), label: "Create Election")
        }.sheet(isPresented: $showingCreateElection) {
            CreateElectionInfo(electionDataCreating: self.$electionDataCreating,
                               showingCreateElection: self.$showingCreateElection)
                .environment(\.managedObjectContext, self.context)
        }
    }
}


struct ActiveHeader: View {
    var body: some View {
        HStack (alignment: .center){
            Text("Active")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(Color.init(.label))
            
            Image(systemName: "flame.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
                .foregroundColor(Color.init(.red))
            
        }
    }
}


struct UpperView: View {
    @FetchRequest(
        entity: Election.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Election.name, ascending: true),
        ]
    ) var allFetchedElections: FetchedResults<Election>
    
    @FetchRequest(
        entity: Election.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Election.name, ascending: true),
        ],
        predicate: NSPredicate(format: "startDate > %@", NSDate())
    ) var pendingFetchedElections: FetchedResults<Election>
    
    @FetchRequest(
        entity: Election.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Election.name, ascending: true),
        ],
        predicate: NSPredicate(format: "endDate < %@", NSDate())
    ) var FinishedFetchedElections: FetchedResults<Election>
    
    var body: some View {
        VStack(spacing: padding) {
            HStack {
                NavigationLink(destination: ElectionList()) {
                    DashboardMainCell(iconName: "checkmark.circle.fill",
                                  status: "Finished",
                                  count: FinishedFetchedElections.count,
                                  iconColor: Color.init(.systemBlue))
                    .frame(width: getSmallCellWidth(), height: cellHeight)
                .background(Color.init(.tertiarySystemBackground))
                    .cornerRadius(16)
                }
                Spacer()
                NavigationLink(destination: ElectionList()) {
                    DashboardMainCell(iconName: "clock.fill",
                                  status: "Pending ",
                                  count: pendingFetchedElections.count,
                                  iconColor: Color.init(.systemYellow))
                .background(Color.init(.tertiarySystemBackground))
                    .frame(width: getSmallCellWidth(), height: cellHeight)
                    .cornerRadius(16)
                }
                
            }
            NavigationLink(destination: ElectionList()) {
                DashboardMainCell(iconName: "tray.full.fill",
                                  status: "All",
                                  count: allFetchedElections.count,
                                  iconColor: Color.init(.systemGray))
                    .frame(width: getLargeCellWidth(), height: cellHeight)
                .background(Color.init(.tertiarySystemBackground))
                    .cornerRadius(16)
            }
        }.padding(.top)
    }
    
    let padding: CGFloat = 20.0
    let cellHeight: CGFloat = 85.0
    
    func getSmallCellWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - padding * 3) / 2
    }
    
    func getLargeCellWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - padding * 2)
    }
    
}

