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


////PRINT MOTHLY 🌕
//struct ReportListView: View {
//    @ObservedObject var dataController: DataController
//    @State private var reports: [Report] = []
//
//    var body: some View {
//
//        List {
//            ForEach(months, id: \.self) { month in
//                let averageFocus = averageFocusForMonth(month)
//                Text("\(month): \(averageFocus != nil ? String(format: "%.2f", averageFocus!) : "Null")")
//            }
//        }
//        .onAppear {
//            fetchReports()
//        }
//
//    }
//
//    private func fetchReports() {
//        reports = dataController.fetchReports()
//    }
//
//    private func averageFocusForMonth(_ month: String) -> Double? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMMM"
//
//        let reportsForMonth = reports.filter { report in
//            guard let timestamp = report.timestamp else { return false }
//            let reportMonth = dateFormatter.string(from: timestamp)
//            return reportMonth == month
//        }
//
//        if reportsForMonth.isEmpty {
//            return nil
//        }
//
//        let totalFocus = reportsForMonth.reduce(0.0) { $0 + ($1.avgAttention ) }
//        return totalFocus / Double(reportsForMonth.count)
//    }
//
//    private var months: [String] {
//        return DateFormatter().monthSymbols
//    }
//}
//


////PRINT YEARLY 🗓️
//struct ReportListView: View {
//    @ObservedObject var dataController: DataController
//    @State private var reports: [Report] = []
//
//    var body: some View {
//        List {
//            ForEach(years.map { String($0) }, id: \.self) { year in
//                let averageFocus = averageFocusForYear(year)
//                Text("\(year): \(averageFocus != nil ? String(format: "%.2f", averageFocus!) : "Null")")
//            }
//        }
//        .onAppear {
//            fetchReports()
//        }
//    }
//
//    private func fetchReports() {
//        reports = dataController.fetchReports()
//    }
//
//    private func averageFocusForYear(_ year: String) -> Double? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy"
//
//        let reportsForYear = reports.filter { report in
//            guard let timestamp = report.timestamp else { return false }
//            let reportYear = dateFormatter.string(from: timestamp)
//            return reportYear == year
//        }
//
//        if reportsForYear.isEmpty {
//            return nil
//        }
//
//        let totalFocus = reportsForYear.reduce(0.0) { $0 + ($1.avgAttention ) }
//        return totalFocus / Double(reportsForYear.count)
//    }
//
//    private var years: [Int] {
//        let calendar = Calendar.current
//        let currentYear = calendar.component(.year, from: Date())
//        //NANTI CURRENT YEARNYA GANTI JADI YEAR FIRST TIME PLAY
//        return Array(currentYear...currentYear+5) // Change the range as needed
//    }
//}


////PRINT WEEKLY 🧮
struct ReportListView: View {
    @ObservedObject var dataController: DataController
    @State private var reports: [Report] = []

    var body: some View {
        List {
            ForEach(weeks, id: \.self) { week in
                let averageFocus = averageFocusForWeek(week: week, reports: reports)
                Text("Week \(week): \(averageFocus != nil ? String(format: "%.2f", averageFocus!) : "Null")")
            }
        }
        .onAppear {
            reports = dataController.fetchReports()
        }
    }

    private var weeks: [Int] {
        return generateWeeksArray()
    }
}


//PRINT DAILY 📅
//struct ReportListView: View {
//    @ObservedObject var dataController: DataController
//    @State private var reports: [Report] = []
//    
//    var body: some View {
//        List {
//            ForEach(days, id: \.self) { day in
//                let averageFocus = averageFocusForDay(day, reports: reports)
//                Text("\(day): \(averageFocus != nil ? String(format: "%.2f", averageFocus!) : "Null")")
//            }
//        }
//        .onAppear {
//            reports = dataController.fetchReports()
//        }
//    }
//    
//    private var days: [String] {
//        let currentYear = Calendar.current.component(.year, from: Date())
//        let currentMonth = Calendar.current.component(.month, from: Date())
//        return generateDaysArray(forYear: currentYear, month: currentMonth)
//    }
//}


struct ReportListView_Previews: PreviewProvider {
    static var previews: some View {
        ReportListView(dataController: DataController())
    }
}
