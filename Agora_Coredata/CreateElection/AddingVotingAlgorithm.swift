//
//  AddingVotingAlgorithm.swift
//  Agora_Coredata
//
//  Created by Abdalla Elsaman on 3/23/20.
//  Copyright © 2020 Dumbies. All rights reserved.
//

import SwiftUI

struct AddingVotingAlgorithm: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var electionDataCreating: ElectionModel
    @Binding var showingCreateElection: Bool
    @State private var AlgorithmIndex = 0
    var algorithms = ["Oklahoma", "RangeVoting", "RankedPairs", "SmithSet", "Approval", "Exhaustive ballot ", "Baldwin", "Uncovered Set", "Copeland", "Minimax Condorcet", "Random Ballot", "Borda", "Kemeny Young", "Nanson ", "Instant Runoff 2-round", "Contingent Method"]
    
    var body: some View {
            List {
                Section (header: Text("Pick Algorithm").font(.headline)){
                    Picker(selection: $AlgorithmIndex, label: EmptyView()) {
                        ForEach(0..<algorithms.count) {
                            Text(self.algorithms[$0]).tag($0)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }.padding(.top)
                
                Section(header:
                    Button(action: {
                        self.saveElection()
                        self.electionDataCreating.clear()
                        self.showingCreateElection.toggle()
                    }, label: {
                        AbstractButtonView(color: .green, label: "Finish")
                    })
                    )
                {
                    EmptyView()
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Voting Algorithm", displayMode: .inline)
    }
    
    private func saveElection() {
        let election = Election(context: self.managedObjectContext)
        election.uid = UUID()
        election.name = self.electionDataCreating.name
        election.des = self.electionDataCreating.description
        election.startDate = self.electionDataCreating.startDate
        election.endDate = self.electionDataCreating.endDate
        election.votingAlgorithm = self.algorithms[self.AlgorithmIndex]
        for candidate in self.electionDataCreating.candidates {
            let candidateData = Candidate(context: self.managedObjectContext)
            candidateData.uid = UUID()
            candidateData.name = candidate.name
            candidateData.election = election
            election.candidates?.adding(candidateData)
        }
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Error")
        }
    }
}

