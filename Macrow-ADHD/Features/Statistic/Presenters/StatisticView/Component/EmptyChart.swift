//
//  EmptyChart.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/13/23.
//

import SwiftUI
import Charts

struct EmptyChart: View {
    @ObservedObject var statisticVm: StatisticViewModel
    var gmtCalendar: Calendar  {
        var calendar = Calendar.current
        calendar.timeZone = .gmt
        return calendar
    }
    
    var xStartDomain: Date {
        if statisticVm.filterDateTime == .dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits) {
            return Date.getHours(date: statisticVm.viewedDate)!.0
        }else if statisticVm.filterDateTime == .dateTime.weekday() {
            return Date.getWeek(date: statisticVm.viewedDate)!.0
        } else {
            return Date.getMonth(date: statisticVm.viewedDate)!.0
        }
    }
    
    var xEndDomain: Date {
        if statisticVm.filterDateTime == .dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits) {
            return Date.getHours(date: statisticVm.viewedDate)!.1
        }else if statisticVm.filterDateTime == .dateTime.weekday() {
            return Date.getWeek(date: statisticVm.viewedDate)!.1
        } else {
            return Date.getMonth(date: statisticVm.viewedDate)!.1
        }
    }
    var body: some View {
        Chart(0...100, id: \.self) {data in
            LineMark(x: .value("Date", Date().startOfDay()!), y: .value("test", 50))
        }
        .chartYAxis{
            AxisMarks(position: .leading, values: [0, 20, 40, 60, 80, 100]) {
                AxisGridLine()
                AxisValueLabel()
                    .font(.label)
                    .foregroundStyle(.brownGuide)
            }
        }
        .chartXScale(
            domain: xStartDomain...xEndDomain
        )
        .chartXAxis{
            if statisticVm.filterDateTime == .dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits) {
                AxisMarks { data in
                    if let hour = data.as(Date.self).map({$0.dateComponents([.hour]).hour}) {
                        if hour! == 0 || hour!%6 == 0 {
                            AxisValueLabel(format: statisticVm.filterDateTime)
                                .font(.label)
                                .foregroundStyle(.brownGuide)
                        }
                    }
                }
            }
            else if statisticVm.filterDateTime == .dateTime.weekday() {
                AxisMarks(values: .stride(by: .day)) { _ in
                    AxisValueLabel(format: statisticVm.filterDateTime)
                        .font(.label)
                        .foregroundStyle(.brownGuide)
                }
            }
            else if statisticVm.filterDateTime == .dateTime.day(){
                AxisMarks(values: statisticVm.viewedDate.daysOfMonth()) { data in
                    if let day = data.as(Date.self).map({$0.dateComponents([.day]).day}) {
                        //                        print(day)
                        if day! == 1 || day!%7 == 1 {
                            
                            AxisValueLabel(format: statisticVm.filterDateTime)
                                .font(.label)
                                .foregroundStyle(.brownGuide)
                        }
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    EmptyChart(statisticVm: StatisticViewModel())
}
