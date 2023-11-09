//
//  SessionChart.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI
import Charts

struct SessionChart: View {
    @State var report: Report
    var body: some View {
        Chart(report.focuses){ chartMarker in
            let baselineMarker = getBaselineMarker(marker: chartMarker)
            
            baselineMarker.symbol(Circle().strokeBorder(lineWidth: 2))
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .minute)) { _ in
                AxisValueLabel(format: .dateTime.minute())
                    .font(.caption1)
                    .foregroundStyle(.brown2)
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
        return LineMark(x: .value("Focus", marker.value), y: .value("Time", marker.time!))
            .lineStyle(StrokeStyle(lineWidth: 2))
            .foregroundStyle(.brown2)
            .opacity(0.5)
            .interpolationMethod(.linear)
            .symbolSize(60)
    }
}

#Preview {
    SessionChart(report: Report())
}
