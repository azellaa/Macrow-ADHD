//
//  StatisticViewSwift.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 10/31/23.
//

import SwiftUI
import Charts

struct StatisticViewSwift: View {
    
    @StateObject var statisticVm = StatisticViewModel()
    
    var viewedRangeProxy: Binding<Int> {
        Binding<Int>(
            get: {
                statisticVm.viewedRange.rawValue
            },
            set: {
                statisticVm.viewedRange = StatisticViewModel.ViewedRangeEnum(rawValue: $0) ?? StatisticViewModel.ViewedRangeEnum.day
            }
        )
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geo  in
            ZStack {
                Rectangle()
                    .fill(.yellow1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        SymbolButton(type: .back, action: {
                            dismiss()
                        })
                        .padding(.leading)
                        .padding()
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.top, Decimal.double41)
                VStack(spacing:0, content: {
                    CustomBoldHeading2(text: AppLabel.statistic)
                        .foregroundStyle(.brown1)
                        .padding(.top, Decimal.double41)
                    CustomSegmentedControl(preselectedIndex: viewedRangeProxy, options: AppLabel.statisticOptions)
                        .frame(maxWidth: 540)
                        .foregroundStyle(.brown1)
                        .font(.body2)
                        .padding(.top, 5)
                        .padding(.bottom, 19)
                    VStack {
                        Group {
                            if statisticVm.viewedRange == .day {
                                HStack {
                                    Text("\(statisticVm.viewedDate.dMMMMFormat())")
                                        .font(.subHeading2)
                                    Spacer()
                                    Text("\(AppLabel.focusAvg) \(statisticVm.averageFocus()!.isNaN ? "\(AppLabel.noFocusValue)" : statisticVm.averageFocus()!.truncated)")
                                        .font(.subHeading2)
                                }
                            }
                            else if statisticVm.viewedRange == .week {
                                HStack {
                                    Text("\(Date.getWeek(date: statisticVm.viewedDate)!.0.dMMMMFormat()) - \(Date.getWeek(date: statisticVm.viewedDate)!.1.dMMMMFormat())")
                                        .font(.subHeading2)
                                    Spacer()
                                    Text("\(AppLabel.focusAvg) \(statisticVm.averageFocus()!.isNaN ? "\(AppLabel.noFocusValue)" : statisticVm.averageFocus()!.truncated)")
                                        .font(.subHeading2)
                                }
                            } else if statisticVm.viewedRange == .month {
                                HStack {
                                    Text("\(Date.getMonth(date: statisticVm.viewedDate)!.0.formatToString("MMMM"))")
                                        .font(.subHeading2)
                                    Spacer()
                                    Text("\(AppLabel.focusAvg) \(statisticVm.averageFocus()!.isNaN ? "\(AppLabel.noFocusValue)" : statisticVm.averageFocus()!.truncated)")
                                        .font(.subHeading2)
                                }
                            }
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                        .padding(.bottom, 94)
                        .foregroundStyle(.brown1)
                        
                        if statisticVm.reports.count == 0 {
                            EmptyChart(statisticVm: self.statisticVm)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 20)
                        } else {
                            FocusChart(statisticVm: self.statisticVm)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 20)
                        }
                        
                        
                        
                    }
                    .background(in: RoundedRectangle(cornerRadius: 25), fillStyle: FillStyle())
                    .frame(width: 972, height: 442)
                    .gesture(DragGesture()
                        .onEnded({ value in
                            if statisticVm.viewedRange == .day {
                                let threshold: CGFloat = 50
                                if value.translation.width > threshold {
                                    withAnimation {
                                        statisticVm.viewedDate = Calendar.current.date(
                                            byAdding: .day,
                                            value: -1,
                                            to: statisticVm.viewedDate
                                        )!
                                        statisticVm.reports = DataController.shared.fetchReportByDay(statisticVm.viewedDate)
                                        statisticVm.selectedReport = nil
                                        //                                        self.focusAverage = averageFocus(reports: self.reports) ?? 0.0
                                    }
                                } else if value.translation.width < -threshold {
                                    withAnimation {
                                        statisticVm.viewedDate = Calendar.current.date(
                                            byAdding: .day,
                                            value: 1,
                                            to: statisticVm.viewedDate
                                        )!
                                        statisticVm.reports = DataController.shared.fetchReportByDay(statisticVm.viewedDate)
                                        statisticVm.selectedReport = nil
                                        //                                        self.focusAverage = averageFocus(reports: self.reports) ?? 0.0
                                    }
                                }
                            }
                        }))
                    AboutCard()
                        .padding(.top, 20)
                    
                })
                
                .padding()
            }
            .ignoresSafeArea()
            
        }
        .onAppear(perform: {
            statisticVm.reports = DataController.shared.fetchReportByDay(statisticVm.viewedDate)
        })
        .onChange(of: statisticVm.viewedRange, perform: { index in
            statisticVm.selectedReport = nil
            if index == .day {
                withAnimation {
                    statisticVm.reports = DataController.shared.fetchReportByDay(statisticVm.viewedDate)
                    statisticVm.strideFilter = .hour
                    statisticVm.filterDateTime = .dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits)
                }
                
            }
            else if index == .week {
                withAnimation {
                    statisticVm.reports = DataController.shared.fetchReportByWeek(statisticVm.viewedDate)
                    statisticVm.strideFilter = .day
                    statisticVm.filterDateTime = .dateTime.weekday()
                }
            }
            else if index == .month {
                withAnimation {
                    statisticVm.reports = DataController.shared.fetchReportByMonth(statisticVm.viewedDate)
                    statisticVm.strideFilter = .day
                    statisticVm.filterDateTime = .dateTime.day()
                }
            }
        })
        .preferredColorScheme(.light)
    }
    
    
    
}


#Preview {
    StatisticViewSwift()
}
