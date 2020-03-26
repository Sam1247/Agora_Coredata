//
//  File.swift
//  Agora_Coredata
//
//  Created by Abdalla Elsaman on 3/23/20.
//  Copyright © 2020 Dumbies. All rights reserved.
//

import Foundation

class ElectionDataCreating: ObservableObject {
    @Published var data: ElectionModel
    init() {
        self.data = ElectionModel()
    }
}

struct CandidateModel: Hashable {
    let name: String
}

struct ElectionModel {
    var name: String = ""
    var description: String = ""
    var startDate: Date = Date()
    var endDate: Date = Date()
    var candidates: [CandidateModel] = [CandidateModel]()
    var votingAlgorithm: String = ""
    
    mutating func clear() {
        self.name = ""
        self.description = ""
        self.startDate = Date()
        self.endDate = Date()
        self.candidates = [CandidateModel]()
        self.votingAlgorithm = ""
    }
}


