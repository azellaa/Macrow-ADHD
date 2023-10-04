//
//  DataController.swift
//  Macrow-ADHD
//
//  Created by Azella Mutyara on 03/10/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "FocusModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved!")
        } catch {
            print("Failed to save data :(")
        }
    }
    
    func addFocus(value: Double, gameID: Int16, context: NSManagedObjectContext) {
        let focus = Focus(context: context)
        focus.id = UUID()
        focus.value = value
        focus.date = Date()
        focus.gameID = gameID
        
        save(context: context)
    }
    
    func fetchAndPrintFocusData() {
        let context = container.viewContext

        do {
            let fetchRequest: NSFetchRequest<Focus> = Focus.fetchRequest()
            let focusData = try context.fetch(fetchRequest)

            for focus in focusData {
                print("Focus ID: \(focus.id ?? UUID())")
                print("Focus Value: \(focus.value)")
                print("Focus Date: \(focus.date ?? Date())")
                print("Game ID: \(focus.gameID)")

            }
        } catch {
            print("Failed to fetch focus data: \(error.localizedDescription)")
        }
    }

}

