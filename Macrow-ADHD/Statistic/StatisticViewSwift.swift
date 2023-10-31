//
//  StatisticViewSwift.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 10/31/23.
//

import SwiftUI
import Charts

struct StatisticViewSwift: View {
    
    
    var dataController = DataController()
    @State var data: [Report] = [Report]()
    @State private var lineWidth = 2.0
    @State private var interpolationMethod: InterpolationMethod = .cardinal
    @State private var chartColor: Color = .blue
    @State private var showSymbols = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.bg)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(content: {
                Text("Statistic")
                    .font(.custom("Jua-Regular", size: 72))
                    .foregroundStyle(.brownGuide)
                HStack {
                    Text("Day")
//                    Text("Week")
//                    Text("Month")
                }
                .foregroundStyle(.brownGuide)
                .font(.custom("Jua-Regular", size: 27))
                
            })
            
        }
        .ignoresSafeArea()
            .onAppear{
                self.data = dataController.fetchReportsWithDate()
                print(data[0].timestamp)
            }
    }
    
//    private var chart: some View {
//        return Chart{
//            ForEach(Array(data.enumerated()), id: \.element) { index, element in
//                LineMark(x: .value("Seconds", index), y: .value("Focus", element))
//                    .lineStyle(StrokeStyle(lineWidth: lineWidth))
//                    .foregroundStyle(chartColor)
//                    .interpolationMethod(interpolationMethod)
//                
//            }
//                
//        }
//    }
}

#Preview {
    StatisticViewSwift()
}
