//
//  AddingCandidate.swift
//  Agora_Coredata
//
//  Created by Abdalla Elsaman on 3/23/20.
//  Copyright © 2020 Dumbies. All rights reserved.
//

import SwiftUI

struct AddingCandidate: View {
    @Binding var electionDataCreating: ElectionModel
    @Binding var showingCreateElection: Bool
    @State var username: String = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        List {
            
            Section {
                TextField("Candidate Name", text: $username)
                    .background(Color.init(.tertiarySystemBackground))
                    .frame(width: (UIScreen.main.bounds.width - 12 * 2) - 12, height: 40)
                    .cornerRadius(12.0)
            }
            
            Section (header:
                    Button(action: {
                        withAnimation {
                            self.electionDataCreating.candidates.append(CandidateModel(name: self.username))
                            self.username = ""
                        }
                    }, label: {
                        AbstractButtonView(color: Color.init(.systemGreen), label: "Add Candidates")
                    })
                )
            {
                EmptyView()
            }
            
            if electionDataCreating.candidates.count != 0 {
                Section(header: Text("Candidates").font(.headline), footer: Text("Swap left to Delete Candidate"))
                {
                    ForEach(electionDataCreating.candidates, id: \.self) {  candidate in
                        AbstractCell(labelname: candidate.name, color: Color.init(.systemGreen), systemNameIcon: "person.circle.fill")
                    }
                    .onDelete(perform: removeCandidate)
                }
            }
            
            Section (header:
                NavigationLink(destination: AddingVotingAlgorithm(electionDataCreating: self.$electionDataCreating ,showingCreateElection: self.$showingCreateElection)) {
                            AbstractButtonView(color: Color.init(.systemYellow), label: "Next")
                        }
                    )
            {
                EmptyView()
            }
            
         }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Adding Candidates", displayMode: .inline)
        .environment(\.horizontalSizeClass, .regular)
    }
    
    func removeCandidate(at offsets: IndexSet) {
        self.electionDataCreating.candidates.remove(atOffsets: offsets)
    }
}

