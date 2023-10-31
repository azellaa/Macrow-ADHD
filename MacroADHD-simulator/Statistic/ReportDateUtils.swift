//
//  ReportDateUtils.swift
//  MacroADHD-simulator
//
//  Created by Azella Mutyara on 25/10/23.
//
import Foundation

func generateDaysArray(forYear year: Int, month: Int) -> [String] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let startDateComponents = DateComponents(calendar: Calendar.current, year: year, month: month, day: 1)
    let endDateComponents = DateComponents(calendar: Calendar.current, year: year, month: month + 1, day: 0)
    
    guard let startDate = startDateComponents.date, let endDate = endDateComponents.date else {
        return []
    }
    
    var currentDate = startDate
    var days: [String] = []
    
    while currentDate <= endDate {
        days.append(dateFormatter.string(from: currentDate))
        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
    }
    
    return days
}

func generateWeeksArray() -> [Int] {
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: Date())
    let weekRange = 1...52 // Assuming there are 52 weeks in a year
    return Array(weekRange)
}
