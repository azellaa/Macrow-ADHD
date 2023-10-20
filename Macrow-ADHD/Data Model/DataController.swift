//
//  DataController.swift
//  Macrow-ADHD
//
//  Created by Azella Mutyara on 03/10/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "ReportModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    private func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved!")
        } catch {
            print("Failed to save data :(")
        }
    }
    
    func addInitialReport(context: NSManagedObjectContext) {
        let report = Report(context: context)
        report.reportId = UUID()
        report.timestamp = Date()
        report.avgAttention = 0.0
        
        save(context: context)
    }
    
    func addGame(gameName: String, level: Int16, context: NSManagedObjectContext){
        let game = Game(context: context)
        game.gameId = UUID()
        game.level = level
        
        save(context: context)
    }
    
    func addAnimal(appearTime: Date, animalTypeId: Int16, animalTYpeName: String, context: NSManagedObjectContext){
        let animal = Animal(context: context)
        animal.animalId = UUID()
        animal.appearTime = appearTime
        let animalType = AnimalType(context: context)
        animalType.animalTypeId = animalTypeId
        animalType.animalTypeName = animalTYpeName
        animal.animalToAnimalType = animalType
        
        save(context: context)
    }
    
    func addFocus(value: Int16, time: Date, report: Report, context: NSManagedObjectContext) {
        let focus = Focus(context: context)
        focus.focusId = UUID()
        focus.time = time
        focus.value = value
        focus.focusToReport = report
        
        save(context: context)
    }
    
    func addPause(startTime: Date, report: Report, context: NSManagedObjectContext){
        let pause = Pause(context: context)
        pause.pauseId = UUID()
        pause.startTime = startTime
        pause.pauseToReport = report
        
        save(context: context)
    }
    
    func addreportToGame(report: Report, game: Game, context: NSManagedObjectContext){
        report.reportToGame = game
        
        save(context: context)
    }
    
    
    
    
    func addFocus(value: Int16, context: NSManagedObjectContext) {
        let focus = Focus(context: context)
        focus.focusId = UUID()
        focus.value = value
        focus.time = Date()
        
        save(context: context)
    }
    
//    func fetchAndPrintFocusData() {
//
//        do {
//            let context = container.viewContext
//            let fetchRequest: NSFetchRequest<Focus> = Focus.fetchRequest()
//            let focusData = try context.fetch(fetchRequest)
//
//            for focus in focusData {
//                print("Focus ID: \(focus.id ?? UUID())")
//                print("Focus Value: \(focus.value)")
//                print("Focus Date: \(focus.date ?? Date())")
//                print("Game ID: \(focus.gameID)")
//
//            }
//        } catch {
//            print("Failed to fetch focus data: \(error.localizedDescription)")
//        }
//    }

    
}

