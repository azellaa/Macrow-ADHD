//
//  DetailStatisticViewSwift.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI

struct DetailStatisticViewSwift: View {
    @State var report: Report
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
                CustomBoldHeading2(text: "Session")
                    .foregroundStyle(.brown2)
                
                GeometryReader(content: { geometry in
                    HStack(spacing: 0) {
                        UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 50))
                            .fill(.white1)
                            .overlay {
                                LeftContent(report: $report)
                            }
                        UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topTrailing: 50))
                            .fill(.darkBrown)
                            .frame(maxWidth: geometry.size.width * 0.3)
                            .overlay {
                                VStack(spacing: 10) {
                                    StatisticElementButton(leftText: "Rabbit Count", rightText: "20")
                                    StatisticElementButton(leftText: "Fox Count", rightText: "20")
                                        .padding(.bottom, Decimal.double60)
                                    
                                    StatisticElementButton(leftText: "Rabbit Count", rightText: "20")
                                    StatisticElementButton(leftText: "Fox Count", rightText: "20")
                                        .padding(.bottom, Decimal.double60)
                                    
                                    
                                    StatisticElementButton(leftText: "Rabbit Count", rightText: "20")
                                    StatisticElementButton(leftText: "Fox Count", rightText: "20")
                                    StatisticElementButton(leftText: "Fox Count", rightText: "20")
                                    
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
    @Binding var report: Report
    var body: some View {
        VStack {
            HStack(content: {
                Text(report.timestamp!.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits)))
                    .padding(.trailing, Decimal.double41)
                Text(report.timestamp!.formatted(.dateTime.hour(.twoDigits(amPM: .omitted)).minute()))
                Spacer()
                Text("\(report.reportToGame!.gameName!) -  Level \(report.reportToGame!.level)")
            })
            .font(.subHeading2)
            .foregroundStyle(.brown2)
            .padding(.horizontal, 40)
            .padding(.top, 66)
            SessionChart(report: report)
        }
    }
}
