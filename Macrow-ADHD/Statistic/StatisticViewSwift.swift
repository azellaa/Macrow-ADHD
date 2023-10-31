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
    let calendar = Calendar.current
    
    @State var reports: [Report] = [Report]()
    @State private var lineWidth = 2.0
    @State private var interpolationMethod: InterpolationMethod = .linear
    @State private var chartColor: Color = .brownColor
    
    @State private var strideFilter: Calendar.Component = .hour
    @State private var filterDateTime: Date.FormatStyle = .dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits)
    @State private var currentDate = Date()
    @State private var focusAverage: Double = 0
    
    private let statisticOptions = ["Day", "Week", "Month"]
    @State private var selectedIndex = 0
    
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
                    
                    CustomSegmentedControl(preselectedIndex: $selectedIndex, options: statisticOptions)
                        .frame(maxWidth: 540)
                    
//                    Button {
//                        withAnimation {
//                            self.reports = dataController.fetchReportByDay(currentDate)
//                            self.strideFilter = .hour
//                            self.filterDateTime = .dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits)
//                        }
//                    } label: {
//                        Text("Day")
//                    }
//                    Button {
//                        withAnimation {
//                            self.reports = dataController.fetchReportByWeek(currentDate)
//                            self.strideFilter = .day
//                            self.filterDateTime = .dateTime.weekday()
//                        }
//                    } label: {
//                        Text("Week")
//                    }
//                    Button {
//                        withAnimation {
//                            self.reports = dataController.fetchReportByMonth(currentDate)
//                            self.strideFilter = .day
//                            self.filterDateTime = .dateTime.day()
//                        }
//                    } label: {
//                        Text("Month")
//                    }
//                    
                    
                }
                .foregroundStyle(.brownGuide)
                .font(.custom("Jua-Regular", size: 27))
                VStack {
                    if strideFilter == .hour {
                        HStack {
                            Text("\(currentDate.dMMMMFormat())")
                                .font(.custom("Jua-Regular", size: 40))
                            
                            Spacer()
                            Text("Focus Average \(focusAverage.truncated)")
                                .font(.custom("Jua-Regular", size: 32))
                        }
                        .padding(.horizontal, 40)
                        .padding()
                        .foregroundStyle(.brownGuide)
                    }
                    
                    
                    chart
                        .padding(36)
                }
                .background(in: RoundedRectangle(cornerRadius: 25), fillStyle: FillStyle())
                .frame(maxWidth: 906, maxHeight: 715)
                .gesture(DragGesture()
                    .onEnded({ value in
                        if strideFilter == .hour {
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold {
                                withAnimation {
                                    
                                    currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
                                    self.reports = dataController.fetchReportByDay(currentDate)
                                    self.focusAverage = averageFocus(reports: self.reports) ?? 0.0
                                }
                            } else if value.translation.width < -threshold {
                                withAnimation {
                                    
                                    currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
                                    self.reports = dataController.fetchReportByDay(currentDate)
                                    self.focusAverage = averageFocus(reports: self.reports) ?? 0.0
                                }
                            }
                        }
                       
                    }))
                
            })
            .padding()
            
            
        }
        .ignoresSafeArea()
        .onAppear{
            self.reports = dataController.fetchReportByDay(currentDate)
            self.focusAverage = averageFocus(reports: self.reports) ?? 0.0
            print(reports.count)
        }
        .onChange(of: self.selectedIndex, perform: { index in
            if index == 0 {
                withAnimation {
                    self.reports = dataController.fetchReportByDay(currentDate)
                    self.strideFilter = .hour
                    self.filterDateTime = .dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits)
                }

            }
            else if index == 1 {
                withAnimation {
                    self.reports = dataController.fetchReportByWeek(currentDate)
                    self.strideFilter = .day
                    self.filterDateTime = .dateTime.weekday()
                }
            }
            else if index == 2 {
                withAnimation {
                    self.reports = dataController.fetchReportByMonth(currentDate)
                    self.strideFilter = .day
                    self.filterDateTime = .dateTime.day()
                }
            }
        })
        .preferredColorScheme(.light)
    }
    
    private var chart: some View {
        return Chart(reports){ report in
            LineMark(x: .value("Date", report.timestamp!), y: .value("Focus", report.avgAttention))
                .lineStyle(StrokeStyle(lineWidth: lineWidth))
                .foregroundStyle(chartColor)
                .interpolationMethod(interpolationMethod)
                .symbol(
                    Circle()
                        .strokeBorder(lineWidth: lineWidth)
                )
                .symbolSize(60)
        }
        
        .chartXAxis{
            AxisMarks(values: .stride(by: self.strideFilter, roundLowerBound: true, roundUpperBound: true)) { _ in
                AxisTick()
                AxisGridLine()
                AxisValueLabel(format: filterDateTime).font(.custom("Jua-Regular", size: 24)).foregroundStyle(.brownGuide)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: [0, 20, 40, 60, 80, 100]) {
                AxisGridLine()
                AxisValueLabel().font(.custom("Jua-Regular", size: 24)).foregroundStyle(.brownGuide)
            }
        }
        .frame(maxHeight: 472)
    }
    
    
}


#Preview {
    StatisticViewSwift()
}
