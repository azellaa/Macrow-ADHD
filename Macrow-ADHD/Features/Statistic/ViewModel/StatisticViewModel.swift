//
//  StatisticViewModel.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/13/23.
//

import Foundation
import SwiftUI
import Charts

class StatisticViewModel: ObservableObject {
    @Published var reports: [Report] = []
    @Published var strideFilter: Calendar.Component = .hour
    @Published var filterDateTime: Date.FormatStyle = .dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits)
    @Published var viewedDate = Date.now
    @Published var viewedRange: ViewedRangeEnum = .day
    
    @Published var selectedReport: Report?
    @Published var lineWidth = 2.0
    @Published var lollipopColor: Color = .yellow1
    @Published var showLollipop = true
    @Published var chartColor: Color = .brown1
    @Published var interpolationMethod: InterpolationMethod = .linear
    
    @Published var selectedElement: DetailStatisticViewSwift.SelectedElementEnum? = nil
    
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

    func averageFocus() -> Double?{
            let totalFocus = reports.reduce(0.0) { $0 + ($1.avgAttention)}
            return totalFocus / Double(reports.count)
        
    }
    
    func changeStatisticElement(statisticElementType: DetailStatisticViewSwift.SelectedElementEnum) {
        if statisticElementType == selectedElement {
            selectedElement = nil
        } else {
            selectedElement = statisticElementType
        }
    }
}

extension StatisticViewModel {
    enum ViewedRangeEnum: Int {
        case day = 0
        case week = 1
        case month = 2
    }
}
