//
//  FocusChart.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI
import Charts

struct FocusChart: View {
    @ObservedObject var statisticVm: StatisticViewModel
    
    var body: some View {
        Chart(statisticVm.reports){ chartMarker in
            PointMark(x: .value("Date", statisticVm.viewedDate), y: .value("test", 100))
                .opacity(0)
            let baselineMarker = getBaselineMarker(marker: chartMarker).opacity(1)
            if CompareSelectedMarkerToChartMarker(selectedMarker: statisticVm.selectedReport, chartMarker: chartMarker) && statisticVm.showLollipop {
                baselineMarker.symbol() {
                    Circle().strokeBorder(statisticVm.chartColor, lineWidth: 2).background(Circle().foregroundColor(statisticVm.lollipopColor)).frame(width: 11)
                }
            } else {
                baselineMarker.symbol(Circle().strokeBorder(lineWidth: statisticVm.lineWidth))
            }
        }
        .chartOverlay { proxy in
            GeometryReader { geo in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        SpatialTapGesture()
                            .onEnded { value in
                                let element = findElement(location: value.location, proxy: proxy, geometry: geo)
                                if statisticVm.selectedReport?.timestamp == element?.timestamp {
                                    // If tapping the same element, clear the selection.
                                    statisticVm.selectedReport = nil
                                } else {
                                    statisticVm.selectedReport = element
                                }
                            }
                            .exclusively(
                                before: DragGesture()
                                    .onChanged { value in
                                        statisticVm.selectedReport = findElement(location: value.location, proxy: proxy, geometry: geo)
                                    }
                            )
                    )
            }
        }
        .chartBackground { proxy in
            ZStack(alignment: .topLeading) {
                GeometryReader { geo in
                    if statisticVm.showLollipop,
                       let selectedReport = statisticVm.selectedReport {
                        let dateInterval = Calendar.current.dateInterval(of: .second, for: selectedReport.timestamp!)!
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
                        NavigationLink {
                            DetailStatisticViewSwift(statisticViewModel: self.statisticVm)
                                .navigationBarBackButtonHidden()
                        } label: {
                            //                            HStack {
                            //                                Spacer()
                            VStack(alignment: .center) {
                                Text("\(selectedReport.avgAttention.truncated)")
                                    .font(.subHeading2)
                                Text("\(selectedReport.reportToGame?.gameName ?? "No Name")")
                                    .font(.body2)
                            }
                            //                                Spacer()
                            //                            }
                        }
                        .buttonStyle(TextButtonStyle(style: .brown, size: .small))
                        
                        //                        .font(.custom("Jua-Regular", size: 32))
                        //                        .foregroundStyle(.white)
                        
                        .accessibilityElement(children: .combine)
                        .frame(width: boxWidth, alignment: .leading)
                        .offset(x: boxOffset, y: -80)
                    }
                }
            }
        }
        
        .chartXAxis{
            
            if statisticVm.filterDateTime == .dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits) {
                
                if let firstReport = statisticVm.reports.first {
                    AxisMarks(values: firstReport.timestamp!.hoursOfDay(using: .gregorian)) { data in
                        if let hour = data.as(Date.self).map({$0.dateComponents([.hour]).hour}) {
                            if hour! == 0 || hour!%6 == 0 {
                                AxisValueLabel(format: statisticVm.filterDateTime)
                                    .font(.label)
                                    .foregroundStyle(.brown1)
                            }
                        }
                    }
                }
                
                
            } else if statisticVm.filterDateTime == .dateTime.weekday() {
                if let firstReport = statisticVm.reports.first {
                    AxisMarks(values: firstReport.timestamp!.daysOfWeek(using: .gregorian) ) { _ in
                        AxisValueLabel(format: statisticVm.filterDateTime)
                            .font(.label)
                            .foregroundStyle(.brown1)
                    }
                }
                
            } else if statisticVm.filterDateTime == .dateTime.day(){
                if let firstReport = statisticVm.reports.first {
                    AxisMarks(values: firstReport.timestamp!.daysOfMonth(using: .gregorian)) { data in
                        if let day = data.as(Date.self).map({$0.dateComponents([.day]).day}) {
                            //                        print(day)
                            if day! == 1 || day!%7 == 1 {
                                
                                AxisValueLabel(format: statisticVm.filterDateTime)
                                    .font(.label)
                                    .foregroundStyle(.brown1)
                            }
                        }
                    }
                }
                
            }
            
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: [0, 20, 40, 60, 80, 100]) {
                AxisGridLine()
                AxisValueLabel()
                    .font(.label)
                    .foregroundStyle(.brown1)
            }
        }
        .frame(maxHeight: 472)
        
    }
    
    private func getBaselineMarker (marker: Report) -> some ChartContent {
        
        return LineMark(
            //FIXME: workaround for timestamp bug
            x: .value("Date", marker.timestamp ?? Date()),
            y: .value("Focus", marker.avgAttention)
        )
        //        .accessibilityLabel(marker.timestamp!.formatted(date: .complete, time: .omitted))
        //        .accessibilityValue("\(marker.avgAttention) sold")
        .lineStyle(StrokeStyle(lineWidth: statisticVm.lineWidth))
        .foregroundStyle(statisticVm.chartColor)
        .opacity(0.5)
        .interpolationMethod(statisticVm.interpolationMethod)
        .symbolSize(60)
    }
    private func CompareSelectedMarkerToChartMarker<T: Equatable>(selectedMarker: T, chartMarker: T) -> Bool {
        return selectedMarker == chartMarker
    }
    
    private func findElement(location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) -> Report?{
        let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
        if let date = proxy.value(atX: relativeXPosition) as Date? {
            // Find the closest date element.
            var minDistance: TimeInterval = .infinity
            var index: Int? = nil
            for salesDataIndex in statisticVm.reports.indices {
                let nthSalesDataDistance = statisticVm.reports[salesDataIndex].timestamp!.distance(to: date)
                if abs(nthSalesDataDistance) < minDistance {
                    minDistance = abs(nthSalesDataDistance)
                    index = salesDataIndex
                }
            }
            if let index {
                return statisticVm.reports[index]
            }
            
        }
        return nil
    }
}

#Preview {
    FocusChart(statisticVm: StatisticViewModel())
}
