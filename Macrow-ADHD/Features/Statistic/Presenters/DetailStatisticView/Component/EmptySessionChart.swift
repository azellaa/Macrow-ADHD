//
//  EmptySessionChart.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/13/23.
//

import SwiftUI
import Charts

struct EmptySessionChart: View {
    var body: some View {
        Chart {
            
        }
        .chartXAxis {
            AxisMarks(position: .bottom, values: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]) { data in
                AxisValueLabel()
                    .font(.label)
                    .foregroundStyle(.brown2)
            }
        }
        .chartYAxis{
            AxisMarks(position: .leading, values: [0, 20, 40, 60, 80, 100]) { data in
                AxisGridLine()
                AxisValueLabel()
                    .font(.label)
                    .foregroundStyle(.brown2)
            }
        }
        .chartXScale(domain: 0...11)
        .chartYScale(domain: 0...100)
    }
}

#Preview {
    EmptySessionChart()
}
