//
//  ReportUtils.swift
//  MacroADHD-simulator
//
//  Created by Azella Mutyara on 25/10/23.
//

import Foundation
import CoreData

func averageFocusForDay(_ day: String, reports: [Report]) -> Double? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let reportsForDay = reports.filter { report in
        guard let timestamp = report.timestamp else { return false }
        let reportDay = dateFormatter.string(from: timestamp)
        return reportDay == day
    }
    
    if reportsForDay.isEmpty {
        return nil
    }
    
    let totalFocus = reportsForDay.reduce(0.0) { $0 + ($1.avgAttention ) }
    return totalFocus / Double(reportsForDay.count)
}

func averageFocusForWeek(week: Int, reports: [Report]) -> Double? {
    let calendar = Calendar.current
    let reportsForWeek = reports.filter { report in
        guard let timestamp = report.timestamp else { return false }
        let reportWeek = calendar.component(.weekOfYear, from: timestamp)
        return reportWeek == week
    }

    if reportsForWeek.isEmpty {
        return nil
    }

    let totalFocus = reportsForWeek.reduce(0.0) { $0 + ($1.avgAttention ) }
    return totalFocus / Double(reportsForWeek.count)
}

func averageFocus(reports: [Report]) -> Double?{
    let totalFocus = reports.reduce(0.0) { $0 + ($1.avgAttention)}
    return totalFocus / Double(reports.count)
}
