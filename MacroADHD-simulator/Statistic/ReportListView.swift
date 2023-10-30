//
//  SwiftUIView.swift
//  MacroADHD-simulator
//
//  Created by Azella Mutyara on 25/10/23.
//

import SwiftUI
import CoreData

//struct ReportListView: View {
//    @ObservedObject var dataController: DataController
//    @State private var reports: [Report] = []
//
//    var body: some View {
//        List(reports, id: \.id) { report in
//            VStack(alignment: .leading) {
//                Text("Report ID: \(report.reportId?.uuidString ?? "")")
//                Text("Game ID: \(report.reportToGame?.gameId?.uuidString ?? "")")
//                Text("Timestamp: \(report.timestamp?.description ?? "")")
//                Text("Average Attention: \(String(format: "%.2f", report.avgAttention))")
//            }
//        }
//        .onAppear {
//            fetchReports()
//        }
//    }
//
//    private func fetchReports() {
//        let context = dataController.container.viewContext
//        let fetchRequest: NSFetchRequest<Report> = Report.fetchRequest()
//
//        do {
//            reports = try context.fetch(fetchRequest)
//        } catch {
//            print("Failed to fetch reports: \(error.localizedDescription)")
//        }
//    }
//}
//
//struct ReportListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReportListView(dataController: DataController())
//    }
//}

struct ReportListView: View {
    @ObservedObject var dataController: DataController
    @State private var reports: [Report] = []
    
    var body: some View {
        
        List {
            ForEach(months, id: \.self) { month in
                let averageFocus = averageFocusForMonth(month)
                Text("\(month): \(averageFocus != nil ? String(format: "%.2f", averageFocus!) : "Null")")
            }
        }
        .onAppear {
            fetchReports()
        }
        
    }
    
    private func fetchReports() {
        reports = dataController.fetchReports()
    }
    
    private func averageFocusForMonth(_ month: String) -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        
        let reportsForMonth = reports.filter { report in
            guard let timestamp = report.timestamp else { return false }
            let reportMonth = dateFormatter.string(from: timestamp)
            return reportMonth == month
        }
        
        if reportsForMonth.isEmpty {
            return nil
        }
        
        let totalFocus = reportsForMonth.reduce(0.0) { $0 + ($1.avgAttention ) }
        return totalFocus / Double(reportsForMonth.count)
    }
    
    private var months: [String] {
        return DateFormatter().monthSymbols
    }
}

struct ReportListView_Previews: PreviewProvider {
    static var previews: some View {
        ReportListView(dataController: DataController())
    }
}

