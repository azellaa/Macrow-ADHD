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
    @State private var selectedReport: Report?
    
    @State private var showLollipop = true
    @State private var lollipopColor: Color = .red
    
    var body: some View {
        GeometryReader { geo  in
            ZStack {
                Rectangle()
                    .fill(.bg)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    HStack {
                        ButtonBack()
                            .padding(.leading)
                            .padding()
                        Spacer()
                    }
                    Spacer()
                }
                VStack(content: {
                    Text(AppLabel.statistic)
                        .font(.Heading.heading2)
                        .foregroundStyle(.brownGuide)
                    CustomSegmentedControl(preselectedIndex: $selectedIndex, options: statisticOptions)
                        .frame(maxWidth: 540)
                        .foregroundStyle(.brownGuide)
                        .font(.custom("Jua-Regular", size: 27))
                    VStack {
                        if selectedIndex == 0 {
                            HStack {
                                Text("\(currentDate.dMMMMFormat())")
                                    .font(.custom("Jua-Regular", size: 40))
                                
                                Spacer()
                                Text("\(AppLabel.focusAvg) \(focusAverage.isNaN ? "\(AppLabel.noFocusValue)" : focusAverage.truncated)")
                                    .font(.custom("Jua-Regular", size: 32))
                            }
                            .padding(.horizontal, 40)
                            .padding()
                            .foregroundStyle(.brownGuide)
                        }
                        
                        if reports.count == 0 {
                            VStack{
                                Text("There’s no data recorded, try to play some games")
                                    .font(.custom("Jua-Regular", size: 32))
                                    .foregroundStyle(.brownGuide)
                            }
                            .frame(maxHeight: 472)
                            
                        } else {
                            chart
                                .padding(36)
                        }
                    }
                    .background(in: RoundedRectangle(cornerRadius: 25), fillStyle: FillStyle())
                    .frame(maxWidth: 906, maxHeight: 715)
                    .gesture(DragGesture()
                        .onEnded({ value in
                            if selectedIndex == 0 {
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
            
        }
        .onAppear{
            self.reports = dataController.fetchReportByDay(currentDate)
            self.focusAverage = averageFocus(reports: self.reports) ?? 0.0
        }
        .onChange(of: self.selectedIndex, perform: { index in
            if index == 0 {
                withAnimation {
                    self.reports = dataController.fetchReportByDay(currentDate)
                    self.strideFilter = .hour
                    self.filterDateTime = .dateTime.hour(.twoDigits(amPM: .omitted))
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
    
    private func CompareSelectedMarkerToChartMarker<T: Equatable>(selectedMarker: T, chartMarker: T) -> Bool {
        return selectedMarker == chartMarker
    }
    
    private func getBaselineMarker (marker: Report) -> some ChartContent {
        return LineMark(
            x: .value("Date", marker.timestamp!),
            y: .value("Focus", marker.avgAttention)
        )
        .accessibilityLabel(marker.timestamp!.formatted(date: .complete, time: .omitted))
        .accessibilityValue("\(marker.avgAttention) sold")
        .lineStyle(StrokeStyle(lineWidth: lineWidth))
        .foregroundStyle(chartColor)
        .opacity(0.5)
        .interpolationMethod(interpolationMethod)
        .symbolSize(60)
    }
    private var chart: some View {
        return Chart(reports){ chartMarker in
            let baselineMarker = getBaselineMarker(marker: chartMarker)
            if CompareSelectedMarkerToChartMarker(selectedMarker: selectedReport, chartMarker: chartMarker) && showLollipop {
                baselineMarker.symbol() {
                    Circle().strokeBorder(chartColor, lineWidth: 2).background(Circle().foregroundColor(lollipopColor)).frame(width: 11)
                }
            } else {
                baselineMarker.symbol(Circle().strokeBorder(lineWidth: lineWidth))
            }
        }
        .chartOverlay { proxy in
            GeometryReader { geo in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        SpatialTapGesture()
                            .onEnded { value in
                                let element = findElement(location: value.location, proxy: proxy, geometry: geo)
                                if selectedReport?.timestamp == element?.timestamp {
                                    // If tapping the same element, clear the selection.
                                    selectedReport = nil
                                } else {
                                    selectedReport = element
                                }
                            }
                            .exclusively(
                                before: DragGesture()
                                    .onChanged { value in
                                        selectedReport = findElement(location: value.location, proxy: proxy, geometry: geo)
                                    }
                            )
                    )
            }
        }
        .chartBackground { proxy in
            ZStack(alignment: .topLeading) {
                GeometryReader { geo in
                    if showLollipop,
                       let selectedReport {
                        let dateInterval = Calendar.current.dateInterval(of: .minute, for: selectedReport.timestamp!)!
                        let startPositionX1 = proxy.position(forX: dateInterval.start) ?? 0
                        
                        let lineX = startPositionX1 + geo[proxy.plotAreaFrame].origin.x
                        let lineHeight = geo[proxy.plotAreaFrame].maxY
                        let boxWidth: CGFloat = 240
                        let boxOffset = max(0, min(geo.size.width - boxWidth, lineX - boxWidth / 2))
                        
                        Rectangle()
                            .fill(.black)
                            .opacity(0.2)
                            .frame(width: 2, height: lineHeight)
                            .position(x: lineX, y: lineHeight / 2)
                        HStack {
                            Spacer()
                            VStack(alignment: .center) {
                                Text("\(selectedReport.avgAttention.truncated)")
                                Text("\(selectedReport.reportToGame?.gameName ?? "No Name")")
                            }
                            Spacer()
                        }
                        
                        .font(.custom("Jua-Regular", size: 32))
                        .foregroundStyle(.white)
                        
                        .accessibilityElement(children: .combine)
                        .frame(width: boxWidth, alignment: .leading)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.brownGuide)
                                .padding(.horizontal, -8)
                                .padding(.vertical, -4)
                        }
                        .offset(x: boxOffset, y: -50)
                    }
                }
            }
        }
        
        .chartXAxis{
            AxisMarks(values: .stride(by: self.strideFilter, roundLowerBound: true, roundUpperBound: true)) { _ in
//                AxisTick()
//                AxisGridLine()
                AxisValueLabel(format: filterDateTime)
                    .font(.custom("Jua-Regular", size: 12))
                    .foregroundStyle(.brownGuide)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: [0, 20, 40, 60, 80, 100]) {
                AxisGridLine()
                AxisValueLabel().font(.Body.body1).foregroundStyle(.brownGuide)
            }
        }
        .frame(maxHeight: 472)
    }
    private func findElement(location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) -> Report?{
        let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
        if let date = proxy.value(atX: relativeXPosition) as Date? {
            // Find the closest date element.
            var minDistance: TimeInterval = .infinity
            var index: Int? = nil
            for salesDataIndex in reports.indices {
                let nthSalesDataDistance = reports[salesDataIndex].timestamp!.distance(to: date)
                if abs(nthSalesDataDistance) < minDistance {
                    minDistance = abs(nthSalesDataDistance)
                    index = salesDataIndex
                }
            }
            if let index {
                return reports[index]
            }
        }
        return nil
    }
    
    
}


#Preview {
    StatisticViewSwift()
}
