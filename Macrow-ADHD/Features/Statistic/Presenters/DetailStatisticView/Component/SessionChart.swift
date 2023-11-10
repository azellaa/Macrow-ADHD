//
//  SessionChart.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI
import Charts

struct SessionChart: View {
    let report: Report
    var focuses: [Focus] {
        report.focusesSortedByTime
    }
    var body: some View {
        Chart (focuses){ chartMarker in
            getBaselineMarker(marker: chartMarker)
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .minute, roundLowerBound: true, roundUpperBound: true)) { data in
                
                if let doubleDuration = data.as(Date.self).map({$0 - focuses.first!.time!.startOfMinute()!}) {
                    AxisValueLabel {
                        VStack {
                            Text((doubleDuration/60).truncated)
                                .font(.caption1)
                                .foregroundStyle(.brown2)
                        }
                    }
                }
                
//                AxisValueLabel(format: .dateTime.minute())
//                    .font(.caption1)
//                    .foregroundStyle(.brown2)
                    
            }
        }
        .chartYAxis {
            AxisMarks (position: .leading, values: [0, 20, 40, 60, 80, 100]) {
                AxisGridLine()
                AxisValueLabel()
                    .font(.caption1)
                    .foregroundStyle(.brown2)
            }
        }
    }
    
    
    
    private func getBaselineMarker (marker: Focus) -> some ChartContent {
        return LineMark(x: .value("Time", marker.time!), y: .value("Focus", Double(marker.value) ))
            .lineStyle(StrokeStyle(lineWidth: 2))
            .foregroundStyle(.brown2)
            .opacity(0.5)
            .interpolationMethod(.catmullRom)
//            .symbolSize(60)
    }
}

extension SessionChart {
    struct dummyFocus {
        var time: Date
        var focus: Int16
        
        static let dummyData = [
            dummyFocus(time: Date().addingTimeInterval(-20), focus: 10),
            dummyFocus(time: Date().addingTimeInterval(-19), focus: 12),
            dummyFocus(time: Date().addingTimeInterval(-18), focus: 21),
            dummyFocus(time: Date().addingTimeInterval(-17), focus: 77),
            dummyFocus(time: Date().addingTimeInterval(-16), focus: 67),
            dummyFocus(time: Date().addingTimeInterval(-15), focus: 27),
            dummyFocus(time: Date().addingTimeInterval(-14), focus: 45),
            dummyFocus(time: Date().addingTimeInterval(-13), focus: 88),
            dummyFocus(time: Date().addingTimeInterval(-12), focus: 65),
            dummyFocus(time: Date().addingTimeInterval(-11), focus: 22),
            dummyFocus(time: Date().addingTimeInterval(-10), focus: 76),
            dummyFocus(time: Date().addingTimeInterval(-9), focus: 76),
            dummyFocus(time: Date().addingTimeInterval(-8), focus: 22),
            dummyFocus(time: Date().addingTimeInterval(-7), focus: 43),
            dummyFocus(time: Date().addingTimeInterval(-6), focus: 35),
            dummyFocus(time: Date().addingTimeInterval(-5), focus: 55),
            dummyFocus(time: Date().addingTimeInterval(-4), focus: 66),
            dummyFocus(time: Date().addingTimeInterval(-3), focus: 88),
            dummyFocus(time: Date().addingTimeInterval(-2), focus: 22),
        ]
    }
//    static let dummyData
}

//#Preview {
//    SessionChart(report: Report())
//}
