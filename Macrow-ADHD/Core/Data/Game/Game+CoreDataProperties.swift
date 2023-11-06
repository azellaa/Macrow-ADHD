//
//  Game+CoreDataProperties.swift
//  Macrow-ADHD
//
//  Created by Ich on 23/10/23.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var gameId: UUID?
    @NSManaged public var gameName: String?
    @NSManaged public var level: Int16
    @NSManaged public var gameToAnimal: Set<Animal>?
    @NSManaged public var gameToReport: Report?

}

// MARK: Generated accessors for gameToAnimal
extension Game {

    @objc(addGameToAnimalObject:)
    @NSManaged public func addToGameToAnimal(_ value: Animal)

    @objc(removeGameToAnimalObject:)
    @NSManaged public func removeFromGameToAnimal(_ value: Animal)

    @objc(addGameToAnimal:)
    @NSManaged public func addToGameToAnimal(_ values: NSSet)

    @objc(removeGameToAnimal:)
    @NSManaged public func removeFromGameToAnimal(_ values: NSSet)

}

extension Game : Identifiable {

}
