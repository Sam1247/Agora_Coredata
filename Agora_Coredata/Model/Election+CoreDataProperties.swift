//
//  Election+CoreDataProperties.swift
//  Agora_Coredata
//
//  Created by Abdalla Elsaman on 3/26/20.
//  Copyright © 2020 Dumbies. All rights reserved.
//
//

import Foundation
import CoreData


extension Election {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Election> {
        return NSFetchRequest<Election>(entityName: "Election")
    }

    @NSManaged public var des: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var uid: UUID?
    @NSManaged public var votingAlgorithm: String?
    @NSManaged public var candidates: NSSet?
    
    

}

// MARK: Generated accessors for candidates
extension Election {

    @objc(addCandidatesObject:)
    @NSManaged public func addToCandidates(_ value: Candidate)

    @objc(removeCandidatesObject:)
    @NSManaged public func removeFromCandidates(_ value: Candidate)

    @objc(addCandidates:)
    @NSManaged public func addToCandidates(_ values: NSSet)

    @objc(removeCandidates:)
    @NSManaged public func removeFromCandidates(_ values: NSSet)

}
