//
//  Macrow_ADHDApp.swift
//  Macrow-ADHD
//
//  Created by Azella Mutyara on 28/09/23.
//

import SwiftUI

@main
struct Macrow_ADHDApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
//            Homepage().environment(\.managedObjectContext, dataController.container.viewContext)
            Homepage()
        }
    }
}
