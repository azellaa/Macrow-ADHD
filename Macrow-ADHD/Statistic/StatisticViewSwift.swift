//
//  StatisticViewSwift.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 10/31/23.
//

import SwiftUI
import Charts

struct StatisticViewSwift: View {
    
    @State var data = FocusDummyData.focusData
    @State private var lineWidth = 2.0
    @State private var interpolationMethod: InterpolationMethod = .cardinal
    @State private var chartColor: Color = .blue
    @State private var showSymbols = false
    
    var body: some View {
        chart
    }
    
    private var chart: some View {
        return Chart{
            ForEach(Array(data.enumerated()), id: \.element) { index, element in
                LineMark(x: .value("Seconds", index), y: .value("Focus", element))
                    .lineStyle(StrokeStyle(lineWidth: lineWidth))
                    .foregroundStyle(chartColor)
                    .interpolationMethod(interpolationMethod)
                
            }
                
        }
    }
}

#Preview {
    StatisticViewSwift()
}
