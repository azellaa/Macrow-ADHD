//
//  DetailStatisticViewSwift.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI

struct DetailStatisticViewSwift: View {
    @ObservedObject var statisticViewModel = StatisticViewModel()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.yellow1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                
                HStack {
                    SymbolButton(type: .back) {
                        dismiss()
                    }
                    .padding(.leading)
                    Spacer()
                    
                }
                Spacer()
            }
            .padding(.top, Decimal.double41)
            
            VStack {
                if let report = statisticViewModel.selectedReport {
                    CustomBoldHeading2(text: report.timestamp!.formatted(
                        .dateTime.day(
                            .twoDigits
                        )
                        .month(
                            .wide
                        )
                        .year(
                            .extended()
                        )
                    )
                    )
                    .foregroundStyle(.brown1)
                    
                    GeometryReader(content: { geometry in
                        HStack(spacing: 0) {
                            UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 50))
                                .fill(.white1)
                                .overlay {
                                    LeftContent(statisticViewModel: self.statisticViewModel)
                                }
                            UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topTrailing: 50))
                                .fill(.brown1)
                                .frame(maxWidth: geometry.size.width * 0.3)
                                .overlay {
                                    VStack(spacing: 10) {
                                        StatisticElementButton(
                                            isActive: statisticViewModel.selectedElement == .rabbitCount,
                                            leftText: AppLabel.StatisticView.rabbitCount,
                                            rightText: "\(report.reportToGame!.getAllRabit.count)",
                                            action: {
                                                statisticViewModel.changeStatisticElement(statisticElementType: .rabbitCount)
                                            }
                                            
                                        )
                                        StatisticElementButton(
                                            isActive: statisticViewModel.selectedElement == .foxCount,
                                            leftText: AppLabel.StatisticView.foxCount,
                                            rightText: "\(report.reportToGame!.getAllFox.count)",
                                            
                                            action: {
                                                statisticViewModel.changeStatisticElement(statisticElementType: .foxCount)
                                            }
                                        )
                                        
                                        .padding(.bottom, Decimal.double60)
                                        
                                        StatisticElementButton(
                                            isActive: statisticViewModel.selectedElement == .pauseCount,
                                            leftText: AppLabel.StatisticView.pauseCount,
                                            rightText: "\(report.reportToPause?.count.description ?? "N/A")",
                                            action: {
                                                statisticViewModel.changeStatisticElement(statisticElementType: .pauseCount)
                                                
                                            }
                                        )
                                        StatisticElementButton(
                                            isActive: statisticViewModel.selectedElement == .pauseAccumulation,
                                            leftText: AppLabel.StatisticView.accumulation,
                                            rightText: "\(((report.getPauseAccumulation ?? 0) / 60).truncated)m \((report.getPauseAccumulation ?? 0).truncatingRemainder(dividingBy: 60).truncated)s",
                                            action: {
                                                statisticViewModel.changeStatisticElement(statisticElementType: .pauseAccumulation)
                                            }
                                        )
                                        .padding(.bottom, Decimal.double60)
                                        
                                        StatisticElementButton(
                                            isActive: statisticViewModel.selectedElement == .highestFocus,
                                            leftText: AppLabel.StatisticView.highestFocus,
                                            rightText: "\(report.getHighestFocus?.description ?? "N/A")",
                                            action: {
                                                statisticViewModel.changeStatisticElement(statisticElementType: .highestFocus)
                                            }
                                        )
                                        StatisticElementButton(
                                            isActive: statisticViewModel.selectedElement == .lowestFocus,
                                            leftText: AppLabel.StatisticView.lowestFocus,
                                            rightText: "\(report.getLowestFocus?.description ?? "N/A")",
                                            action: {
                                                statisticViewModel.changeStatisticElement(statisticElementType: .lowestFocus)
                                            }
                                        )
                                        StatisticElementButton(
                                            isActive: statisticViewModel.selectedElement == .averageFocus,
                                            leftText: AppLabel.StatisticView.averageFocus,
                                            rightText: "\(report.getAverageFocus?.truncated ?? "N/A")",
                                            action: {
                                                statisticViewModel.changeStatisticElement(statisticElementType: .averageFocus)
                                            }
                                        )
                                        
                                    }
                                    .padding(.top, 66)
                                    .padding(.bottom, 18)
                                }
                        }
                        .padding(.top, 44)
                    })
                }
                
            }
            .padding(.top, Decimal.double41)
        }
        .ignoresSafeArea()
    }
}

extension DetailStatisticViewSwift {
    enum SelectedElementEnum {
        case rabbitCount
        case foxCount
        case pauseCount
        case pauseAccumulation
        case highestFocus
        case averageFocus
        case lowestFocus
    }
    
}

#Preview {
    DetailStatisticViewSwift(statisticViewModel: StatisticViewModel())
}

struct LeftContent: View {
    @ObservedObject var statisticViewModel = StatisticViewModel()
    var body: some View {
        VStack {
            if let report = statisticViewModel.selectedReport {
                HStack(content: {
                    Text(report.timestamp!.formatted(.dateTime.hour(.twoDigits(amPM: .omitted)).minute()))
                    Spacer()
                    Text("\(report.reportToGame!.gameName!) -  Level \(report.reportToGame!.level)")
                })
                .font(.subHeading2)
                .foregroundStyle(.brown1)
                .padding(.horizontal, 40)
                .padding(.top, 66)
                if !report.focuses.isEmpty {
                    SessionChart(statisticViewModel: self.statisticViewModel)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 35)
                } else {
                    EmptySessionChart()
                        .padding(.horizontal, 40)
                        .padding(.vertical, 35)
                }
                
            }
        }
    }
}
