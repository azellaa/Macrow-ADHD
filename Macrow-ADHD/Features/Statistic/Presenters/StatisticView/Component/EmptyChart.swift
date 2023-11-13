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
    var body: some View {
        Chart(0...100, id: \.self) {data in
            LineMark(x: .value("Date", Date().startOfDay()!), y: .value("test", 50))
//                .lineStyle(StrokeStyle(lineWidth: statisticVm.lineWidth))
//                .foregroundStyle(statisticVm.chartColor)
//                .opacity(0.5)
//                .interpolationMethod(statisticVm.interpolationMethod)
//                .symbolSize(60)
//                .opacity(0)
        }
        .chartYAxis{
            AxisMarks(position: .leading, values: [0, 20, 40, 60, 80, 100]) {
                AxisGridLine()
                AxisValueLabel()
                    .font(.caption1)
                    .foregroundStyle(.brownGuide)
            }
        }
        .chartXAxis{
//            if statisticVm.filterDateTime == .dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits) {
                AxisMarks(values: Date().hoursOfDay()) { data in
                    if let hour = data.as(Date.self).map({$0.dateComponents([.hour]).hour}) {
                        if hour! == 0 || hour!%6 == 0 {
                            AxisValueLabel(format:.dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits))
                                .font(.caption1)
                                .foregroundStyle(.brownGuide)
                        }
                    }
                }
                
                
//            } else if statisticVm.filterDateTime == .dateTime.weekday() {
//                AxisMarks(values: statisticVm.viewedDate.daysOfWeek() ) { _ in
//                    AxisValueLabel(format: statisticVm.filterDateTime)
//                        .font(.caption1)
//                        .foregroundStyle(.brownGuide)
//                }
//                
//            } else if statisticVm.filterDateTime == .dateTime.day(){
//                AxisMarks(values: statisticVm.viewedDate.daysOfMonth()) { data in
//                    if let day = data.as(Date.self).map({$0.dateComponents([.day]).day}) {
//                        //                        print(day)
//                        if day! == 1 || day!%7 == 1 {
//                            
//                            AxisValueLabel(format: statisticVm.filterDateTime)
//                                .font(.caption1)
//                                .foregroundStyle(.brownGuide)
//                        }
//                    }
//                }
//            }
        }
        
        
    }
}

#Preview {
    EmptyChart(statisticVm: StatisticViewModel())
}
