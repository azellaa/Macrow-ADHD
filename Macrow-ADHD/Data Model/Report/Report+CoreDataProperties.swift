//
//  Report+CoreDataProperties.swift
//  Macrow-ADHD
//
//  Created by Ich on 23/10/23.
//
//

import Foundation
import CoreData


extension Report {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Report> {
        return NSFetchRequest<Report>(entityName: "Report")
    }

    @NSManaged public var avgAttention: Double
    @NSManaged public var reportId: UUID?
    @NSManaged public var timestamp: Date?
    @NSManaged public var reportToFocus: Set<Focus>?
    @NSManaged public var reportToGame: Game?
    @NSManaged public var reportToPause: Set<Pause>?
    @NSManaged public var reportToDisconnect: Set<DisconnectEntity>?
    

}


// MARK: Generated accessors for reportToFocus
extension Report {

    @objc(addReportToFocusObject:)
    @NSManaged public func addToReportToFocus(_ value: Focus)

    @objc(removeReportToFocusObject:)
    @NSManaged public func removeFromReportToFocus(_ value: Focus)

    @objc(addReportToFocus:)
    @NSManaged public func addToReportToFocus(_ values: NSSet)

    @objc(removeReportToFocus:)
    @NSManaged public func removeFromReportToFocus(_ values: NSSet)

}

// MARK: Generated accessors for reportToPause
extension Report {

    @objc(addReportToPauseObject:)
    @NSManaged public func addToReportToPause(_ value: Pause)

    @objc(removeReportToPauseObject:)
    @NSManaged public func removeFromReportToPause(_ value: Pause)

    @objc(addReportToPause:)
    @NSManaged public func addToReportToPause(_ values: NSSet)

    @objc(removeReportToPause:)
    @NSManaged public func removeFromReportToPause(_ values: NSSet)

}

// MARK: Generated accessors for reportToDisconnect
extension Report {

    @objc(addReportToDisconnectObject:)
    @NSManaged public func addToReportToDisconnect(_ value: DisconnectEntity)

    @objc(removeReportToDisconnectObject:)
    @NSManaged public func removeFromReportToDisconnect(_ value: DisconnectEntity)

    @objc(addReportToDisconnect:)
    @NSManaged public func addToReportToDisconnect(_ values: NSSet)

    @objc(removeReportToDisconnect:)
    @NSManaged public func removeFromReportToDisconnect(_ values: NSSet)

}


extension Report : Identifiable {

}
