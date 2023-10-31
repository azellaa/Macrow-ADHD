//
//  DataController.swift
//  Macrow-ADHD
//
//  Created by Azella Mutyara on 03/10/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentCloudKitContainer(name: "ReportModel")
    
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
    
    func addInitialReport(game: Game, context: NSManagedObjectContext) -> Report{
        let report = Report(context: context)
        report.reportId = UUID()
        report.timestamp = Date()
        report.avgAttention = 0.0
        report.reportToGame = game
        
        save(context: context)
        
        return report
    }
    
    func addGame(gameName: String, level: Int16, context: NSManagedObjectContext) -> Game{
        let game = Game(context: context)
        game.gameId = UUID()
        game.level = level
        
        save(context: context)
        
        return game
    }
    
    func addAnimal(appearTime: Date, animalTypeEnum: AnimalTypeEnum, game: Game, context: NSManagedObjectContext) -> Animal{
        let animal = Animal(context: context)
        animal.animalId = UUID()
        animal.appearTime = appearTime
        let animalType = AnimalType(context: context)
        animalType.animalTypeId =  Int16(animalTypeEnum.id)
        animalType.animalTypeName = animalTypeEnum.name
        animal.animalToAnimalType = animalType
        
        animal.animalToGame = game
        
        #if DEBUG
        print(animal)
        #endif
        
        save(context: context)
        
        return animal
        
    }
    
    func addFocus(value: Int16, time: Date, report: Report, context: NSManagedObjectContext) {
        let focus = Focus(context: context)
        focus.focusId = UUID()
        focus.time = time
        focus.value = value
        focus.focusToReport = report
        
        save(context: context)
    }
    
    func addPause(startTime: Date, report: Report, context: NSManagedObjectContext) -> Pause{
        let pause = Pause(context: context)
        pause.pauseId = UUID()
        pause.startTime = startTime
        pause.pauseToReport = report
        
        save(context: context)
        
        return pause
    }
    
    func addDisconnect(startTime: Date, report: Report, context: NSManagedObjectContext) -> DisconnectEntity {
        let disconnect = DisconnectEntity(context: context)
        disconnect.disconnectId = UUID()
        disconnect.startTime = startTime
        disconnect.disconnectToReport = report
        print("Disconnect Saved")
        
        save(context: context)
        
        return disconnect
    }
    
    func addreportToGame(report: Report, game: Game, context: NSManagedObjectContext){
        report.reportToGame = game
        
        save(context: context)
    }
    
    func editPauseEndTime(pause: Pause, endTime: Date, context: NSManagedObjectContext) {
        pause.endTime = endTime
        
        save(context: context)
    }
    
    func editDisconnectEndTime(disconnect: DisconnectEntity, endTime: Date, context: NSManagedObjectContext) {
        disconnect.endTime = endTime
        
        save(context: context)
    }
    
    func editAvgAttentionReport(report: Report, avgAttention: Double, context: NSManagedObjectContext){
        report.avgAttention = avgAttention
        
        save(context: context)
    }
    
    func editAnimalTapTime(animal: Animal, tapTime: Date, context: NSManagedObjectContext){
        animal.tapTime = tapTime
        #if DEBUG
        print(animal)
        #endif
        save(context: context)
        
    }
    

    
    
    
//    func addFocus(value: Int16, context: NSManagedObjectContext) {
//        let focus = Focus(context: context)
//        focus.focusId = UUID()
//        focus.value = value
//        focus.time = Date()
//        
//        save(context: context)
//    }
    
    func fetchAndPrintFocusData() {

        do {
            let context = container.viewContext
            let fetchRequest: NSFetchRequest<Report> = Report.fetchRequest()
            let reportData = try context.fetch(fetchRequest)

            for report in reportData {
                
                print("Report ID: \(report.reportId ?? UUID())")
                print("FocusData: \(report.focuses)")
                print("PauseData: \(report.pauses)")
                
                print("Average Focus Value: \(report.avgAttention)")
//                print("Focus Date: \(focus.date ?? Date())")
//                print("Game ID: \(focus.gameID)")

            }
        } catch {
            print("Failed to fetch focus data: \(error.localizedDescription)")
        }
    }
    
    func fetchReports() -> [Report] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<Report> = Report.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch reports: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchReportsWithDate() -> [Report] {
        let context = container.viewContext
        // Optional(2023-10-22 17:45:15 +0000)
        
        let fetchRequest: NSFetchRequest<Report> = Report.fetchRequest()
        
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let dateFromString = dateFormat.date(from: "2023-10-22")!
        let formattedDate = dateFormat.string(from: dateFromString)
        
        
        fetchRequest.predicate = NSPredicate(format: "timestamp = %@", formattedDate)

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch reports: \(error.localizedDescription)")
            return []
        }
    }
    
}

