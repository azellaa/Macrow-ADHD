//
//  Date+extension.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 10/31/23.
//

import Foundation

extension Date {
    func dMMMMFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: self)
    }
    
    func formatToString(_ format: String = "dd MM YYYY") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    
}

extension Date {
    static func getWeek(date: Date = Date()) -> (Date, Date)? {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) // Start of the current week
        let endOfWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: startOfWeek!) // Start of the next week
        if let startOfWeek = startOfWeek, let endOfWeek = endOfWeek {
            return (startOfWeek, endOfWeek)
        }else {
            return nil
        }
    }
    static func getMonth(date: Date = Date()) -> (Date, Date)? {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) // Start of the current month
        let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth!) // Start of the next month
        if let startOfMonth = startOfMonth, let endOfMonth = endOfMonth {
            return (startOfMonth, endOfMonth)
        }else {
            return nil
        }
    }
}

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

