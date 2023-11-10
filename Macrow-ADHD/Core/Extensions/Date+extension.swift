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
        let startOfMonth = date.startOfMonth()?.byAdding(component: .day, value: 1) // Start of the current month
        let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth!) // Start of the next month
        if let startOfMonth = startOfMonth, let endOfMonth = endOfMonth?.byAdding(component: .day, value: -1) {
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
    func dateComponents(_ components: Set<Calendar.Component>, using calendar: Calendar = .current) -> DateComponents {
        calendar.dateComponents(components, from: self)
    }
    
    func startOfMinute() -> Date?
    {
        let calendar = Calendar.current

        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)

//        components.minute = 0
        components.second = 0

        return calendar.date(from: components)
    }
    
    func startOfDay() -> Date?
    {
        let calendar = Calendar.current

        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)

        components.hour = 0
        components.minute = 0
        components.second = 0

        return calendar.date(from: components)
    }
    
    func startOfWeek(using calendar: Calendar = .current) -> Date {
        calendar.date(from: dateComponents([.yearForWeekOfYear, .weekOfYear], using: calendar))!
    }
    func startOfMonth() -> Date? {
        let calendar = Calendar.current

        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)

        components.day = 0

        return calendar.date(from: components)
    }
    
    func byAdding(component: Calendar.Component, value: Int, wrappingComponents: Bool = false, using calendar: Calendar = .current) -> Date? {
        calendar.date(byAdding: component, value: value, to: self, wrappingComponents: wrappingComponents)
    }


    var dawn: Date {
        Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
        
    }
    var noon: Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    func hoursOfDay(using calendar: Calendar = .current) -> [Date] {
        let startOfDay = self.startOfDay()
        let range = calendar.range(of: .hour, in: .day, for: startOfDay!)
        return range?.map({startOfDay?.byAdding(component: .hour, value: $0,using: calendar)!}) as! [Date]
//        return (0...7).map { startOfWeek.byAdding(component: .day, value: $0, using: calendar)! }
    }
    
    func daysOfWeek(using calendar: Calendar = .current) -> [Date] {
        let startOfWeek = self.startOfWeek(using: calendar).dawn
        return (0...7).map { startOfWeek.byAdding(component: .day, value: $0, using: calendar)! }
    }
    func daysOfMonth(using calendar: Calendar = .current) -> [Date] {
        let startOfMonth = self.startOfMonth()
        let range = calendar.range(of: .day, in: .month, for: startOfMonth!)
        return(range?.map({
            startOfMonth!.byAdding(component: .day, value: $0, using: calendar)!
        }))!
//        return (0...range!.count).map { startOfMonth.byAdding(component: .day, value: $0, using: calendar)! }
    }
    
}

