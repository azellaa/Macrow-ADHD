//
//  FocusChart.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI
import Charts

struct FocusChart: View {
    var reports: [Report]
    @State private var selectedReport: Report?
    @State private var lineWidth = 2.0
    @State private var lollipopColor: Color = .yellow1
    @State private var showLollipop = true
    var chartColor: Color = .brownColor
    @State var interpolationMethod: InterpolationMethod = .linear
    @Binding var filterDateTime: Date.FormatStyle
    var strideFilter: Calendar.Component
    
    var body: some View {
        Chart(reports){ chartMarker in
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
                            DetailStatisticViewSwift(report: selectedReport)
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
//                        .background {
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill(.brownGuide)
//                                .padding(.horizontal, -8)
//                                .padding(.vertical, -4)
//                        }
                        .offset(x: boxOffset, y: -80)
                    }
                }
            }
        }
        
        .chartXAxis{
            AxisMarks(values: .stride(by: self.strideFilter, roundLowerBound: true, roundUpperBound: true)) { _ in
                //                AxisTick()
                //                AxisGridLine()
                AxisValueLabel(format: filterDateTime)
                    .font(.caption1)
                    .foregroundStyle(.brownGuide)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: [0, 20, 40, 60, 80, 100]) {
                AxisGridLine()
                AxisValueLabel()
                    .font(.caption1)
                    .foregroundStyle(.brownGuide)
            }
        }
        .frame(maxHeight: 472)
    }
    
    private func getBaselineMarker (marker: Report) -> some ChartContent {
        return LineMark(
            x: .value("Date", marker.timestamp!),
            y: .value("Focus", marker.avgAttention)
        )
//        .accessibilityLabel(marker.timestamp!.formatted(date: .complete, time: .omitted))
//        .accessibilityValue("\(marker.avgAttention) sold")
        .lineStyle(StrokeStyle(lineWidth: lineWidth))
        .foregroundStyle(chartColor)
        .opacity(0.5)
        .interpolationMethod(interpolationMethod)
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
    FocusChart(reports: [Report](), filterDateTime: .constant(.dateTime.day()), strideFilter: .hour)
}
