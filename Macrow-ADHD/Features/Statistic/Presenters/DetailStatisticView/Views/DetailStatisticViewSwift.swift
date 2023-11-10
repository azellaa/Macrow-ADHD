//
//  DetailStatisticViewSwift.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI

struct DetailStatisticViewSwift: View {
    var report: Report
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.bg)
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
                CustomBoldHeading2(text: report.timestamp!.formatted(.dateTime.day(.twoDigits).month(.wide).year(.extended())))
                    .foregroundStyle(.brown1)
                
                GeometryReader(content: { geometry in
                    HStack(spacing: 0) {
                        UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 50))
                            .fill(.white1)
                            .overlay {
                                LeftContent(report: report)
                            }
                        UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topTrailing: 50))
                            .fill(.brown1)
                            .frame(maxWidth: geometry.size.width * 0.3)
                            .overlay {
                                VStack(spacing: 10) {
                                    StatisticElementButton(leftText: AppLabel.StatisticView.rabbitCount, rightText: "\(report.reportToGame!.getAllRabit.count)")
                                    StatisticElementButton(leftText: AppLabel.StatisticView.foxCount, rightText: "\(report.reportToGame!.getAllFox.count)")
                                        .padding(.bottom, Decimal.double60)
                                    
                                    StatisticElementButton(leftText: AppLabel.StatisticView.pauseCount, rightText: "\(report.reportToPause?.count.description ?? "N/A")")
                                    StatisticElementButton(leftText: AppLabel.StatisticView.accumulation, rightText: "\(((report.getPauseAccumulation ?? 0) / 60).truncated)m \((report.getPauseAccumulation ?? 0).truncatingRemainder(dividingBy: 60).truncated)s")
                                        .padding(.bottom, Decimal.double60)
                                    
                                    
                                    StatisticElementButton(leftText: AppLabel.StatisticView.highestFocus, rightText: "\(report.getHighestFocus?.description ?? "N/A")")
                                    StatisticElementButton(leftText: AppLabel.StatisticView.lowestFocus, rightText: "\(report.getLowestFocus?.description ?? "N/A")")
                                    StatisticElementButton(leftText: AppLabel.StatisticView.averageFocus, rightText: "\(report.getAverageFocus?.truncated ?? "N/A")")
                                    
                                }
                                .padding(.top, 66)
                                .padding(.bottom, 18)
                            }
                    }
                })
            }
            .padding(.top, Decimal.double41)
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    DetailStatisticViewSwift(report: Report())
}

struct LeftContent: View {
    let report: Report
    var body: some View {
        VStack {
            HStack(content: {
                Text(report.timestamp!.formatted(.dateTime.hour(.twoDigits(amPM: .omitted)).minute()))
                Spacer()
                Text("\(report.reportToGame!.gameName!) -  Level \(report.reportToGame!.level)")
            })
            .font(.subHeading2)
            .foregroundStyle(.brown1)
            .padding(.horizontal, 40)
            .padding(.top, 66)
            SessionChart(report: report)
                .padding(.horizontal, 40)
                .padding(.vertical, 35)
        }
    }
}
