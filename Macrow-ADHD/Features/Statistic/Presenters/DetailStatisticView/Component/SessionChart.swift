//
//  SessionChart.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI
import Charts

struct SessionChart: View {
    @ObservedObject var statisticViewModel = StatisticViewModel()
    var focuses: [Focus]? {
        if let report = statisticViewModel.selectedReport {
            return report.focusesSortedByTime
        } else {
            return nil
        }
    }
    
    var averagedReport: [AveragedReport]? {
        if let report = statisticViewModel.selectedReport {
            return report.averagedReports
        } else {
            return nil
        }
    }
    var body: some View {
        Chart {
            if statisticViewModel.selectedElement == .pauseCount || statisticViewModel.selectedElement == .pauseAccumulation {
                ForEach(statisticViewModel.selectedReport!.pauses) { chartMarker in
                    if let startPause = chartMarker.startTime, let endPause = chartMarker.endTime {
                        BarMark(xStart: .value("Pause Start", startPause), xEnd: .value("Pause End", endPause))
                            .foregroundStyle(.yellow2)
                            .annotation(position: .automatic, alignment: .center) {
                                if statisticViewModel.selectedElement == .pauseAccumulation {
                                    if (endPause - startPause) >= 10 {
                                        Text("\((endPause - startPause).truncated)s")
                                            .font(.label)
                                            .foregroundStyle(.yellow2)
                                    }
                                }
                            }
                    }
                }
            }
            
            ForEach(averagedReport!, id: \.time) { chartMarker in
                baselineAveragedReport(marker: chartMarker)
            }
            
            if statisticViewModel.selectedElement == .rabbitCount {
                //MARK: RABBIT COUNT
                ForEach((statisticViewModel.selectedReport?.reportToGame!.getAllRabit)!) { chartMarker in
                    baseLineRabbitCount(marker: chartMarker)
                }
            }
            
            if statisticViewModel.selectedElement == .foxCount {
                //MARK: FOX COUNT
                ForEach((statisticViewModel.selectedReport?.reportToGame!.getAllFox)!) { chartMarker in
                    baseLineFoxCount(marker: chartMarker)
                }
            }
            
            
            if let report = statisticViewModel.selectedReport {
                
                if statisticViewModel.selectedElement == .lowestFocus {
                    //MARK: LOWEST FOCUS
                    RuleMark(y: .value("Lowest Focus", report.getLowestFocus!))
                        .annotation(position: .trailing) {
                            Text("\(report.getLowestFocus!)")
                                .font(.label)
                                .foregroundStyle(.yellow2)
                        }
                        .foregroundStyle(.yellow2)
                }
                
                if statisticViewModel.selectedElement == .highestFocus{
                    //MARK: HIGHEST FOCUS
                    RuleMark(y: .value("Highest Focus", report.getHighestFocus!))
                        .annotation(position: .trailing) {
                            Text("\(report.getHighestFocus!)")
                                .font(.label)
                                .foregroundStyle(.yellow2)
                        }
                        .foregroundStyle(.yellow2)
                }
                
                if statisticViewModel.selectedElement == .averageFocus {
                    //MARK: AVERAGE FOCUS
                    RuleMark(y: .value("Average Focus", report.getAverageFocus!))
                        .annotation(position: .trailing) {
                            Text("\(report.getAverageFocus!.truncated)")
                                .font(.label)
                                .foregroundStyle(.yellow2)
                        }
                        .foregroundStyle(.yellow2)
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .minute, roundLowerBound: true, roundUpperBound: true)) { data in
                if let doubleDuration = data.as(Date.self).map({$0 - focuses!.first!.time!.startOfMinute()!}) {
                    AxisValueLabel {
                        VStack {
                            Text((doubleDuration/60).truncated)
                                .font(.label)
                                .foregroundStyle(.brown2)
                        }
                    }
                }
                
            }
        }
        .chartYAxis {
            AxisMarks (position: .leading, values: [0, 20, 40, 60, 80, 100]) {
                AxisGridLine()
                AxisValueLabel()
                    .font(.label)
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
    }
    
    private func baselineAveragedReport (marker: AveragedReport) -> some ChartContent {
        return LineMark(x: .value("Time", marker.time!), y: .value("Focus", marker.averagedValue))
            .lineStyle(StrokeStyle(lineWidth: 2))
            .foregroundStyle(.brown2)
            .opacity(0.5)
            .interpolationMethod(.catmullRom)
    }
    
    private func baseLineRabbitCount (marker: Animal) -> some ChartContent {
        if let tapTime = marker.tapTime {
            
            return PointMark(x: .value("Time", tapTime))
                .lineStyle(StrokeStyle(lineWidth: 2))
                .foregroundStyle(.yellow)
                .interpolationMethod(.catmullRom)
        } else {
            
            return PointMark(x: .value("Time", marker.appearTime!))
                .lineStyle(StrokeStyle(lineWidth: 2))
                .foregroundStyle(.red)
                .interpolationMethod(.catmullRom)
        }
    }
    
    private func baseLineFoxCount (marker: Animal) -> some ChartContent {
        if let tapTime = marker.tapTime {
            
            return PointMark(x: .value("Time", tapTime))
                .lineStyle(StrokeStyle(lineWidth: 2))
                .foregroundStyle(.red)
            //                .opacity(0.5)
                .interpolationMethod(.catmullRom)
        } else {
            
            return PointMark(x: .value("Time", marker.appearTime!))
                .lineStyle(StrokeStyle(lineWidth: 2))
                .foregroundStyle(.yellow)
            //                .opacity(0.5)
                .interpolationMethod(.catmullRom)
        }
        //            .symbolSize(60)
    }
}

//#Preview {
//    SessionChart(report: Report())
//}
