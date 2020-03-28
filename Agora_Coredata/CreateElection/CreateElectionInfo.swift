//
//  CreateElectionInfo.swift
//  Agora_Coredata
//
//  Created by Abdalla Elsaman on 3/23/20.
//  Copyright © 2020 Dumbies. All rights reserved.
//

import SwiftUI

struct CreateElectionInfo: View {
    @Binding var electionDataCreating: ElectionModel
    @Binding var showingCreateElection: Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Name").font(.headline).padding(.top)) {
                    AbstractTextField(label: "Election Name", binding: self.$electionDataCreating.name)
                }
                
                Section(header: Text("Description").font(.headline)) {
                    AbstractTextField(label: "Election Description", binding: $electionDataCreating.description)
                }
                
                DatePicker(selection: $electionDataCreating.startDate) {
                    Text("Start Date")
                }

                DatePicker(selection: $electionDataCreating.endDate) {
                    Text("End Date")
                }
                
                Section (header:
                    NavigationLink(destination: AddingCandidate(electionDataCreating: self.$electionDataCreating ,
                                                                showingCreateElection: self.$showingCreateElection)) {
                                AbstractButtonView(color: Color.init(.systemYellow), label: "Next")
                            }
                        )
                {
                    EmptyView()
                }.padding(.top)
                
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Election Info", displayMode: .inline)
        }
       
        .navigationViewStyle(StackNavigationViewStyle())
    }

}

struct AbstractTextField: View {
    var label: String
    @Binding var binding: String
    var body: some View {
        TextField(label , text: $binding)
            //.background(Color.init(.tertiarySystemBackground))
            .frame(width: (UIScreen.main.bounds.width - 12 * 2) - 12, height: 40)
            .cornerRadius(12.0)
    }
}

