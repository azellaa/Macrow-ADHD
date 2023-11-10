//
//  StatisticViewSwift.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 10/31/23.
//

import SwiftUI
import Charts

struct StatisticViewSwift: View {
    
    let calendar = Calendar.current
    
    @State var reports: [Report] = []
    
    @State private var strideFilter: Calendar.Component = .hour
    @State private var filterDateTime: Date.FormatStyle = .dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits)
    @State private var currentDate = Date()
    @State private var focusAverage: Double = 0
    
    @State private var selectedIndex = 0
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        GeometryReader { geo  in
            ZStack {
                Rectangle()
                    .fill(.bg)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                    CustomSegmentedControl(preselectedIndex: $selectedIndex, options: AppLabel.statisticOptions)
                        .frame(maxWidth: 540)
                        .foregroundStyle(.brown1)
                        .font(.body2)
                        .padding(.top, 5)
                        .padding(.bottom, 19)
                    VStack {
                        Group {
                            if selectedIndex == 0 {
                                HStack {
                                    Text("\(currentDate.dMMMMFormat())")
                                        .font(.subHeading2)
                                    Spacer()
                                    Text("\(AppLabel.focusAvg) \(focusAverage.isNaN ? "\(AppLabel.noFocusValue)" : focusAverage.truncated)")
                                        .font(.subHeading2)
                                }
                            }
                            else if selectedIndex == 1 {
                                HStack {
                                    Text("\(Date.getWeek(date: currentDate)!.0.dMMMMFormat()) - \(Date.getWeek(date: currentDate)!.1.dMMMMFormat())")
                                        .font(.subHeading2)
                                    Spacer()
                                    Text("\(AppLabel.focusAvg) \(focusAverage.isNaN ? "\(AppLabel.noFocusValue)" : focusAverage.truncated)")
                                        .font(.subHeading2)
                                }
                            } else if selectedIndex == 2 {
                                HStack {
                                    Text("\(Date.getMonth(date: currentDate)!.0.formatToString("MMMM"))")
                                        .font(.subHeading2)
                                    Spacer()
                                    Text("\(AppLabel.focusAvg) \(focusAverage.isNaN ? "\(AppLabel.noFocusValue)" : focusAverage.truncated)")
                                        .font(.subHeading2)
                                }
                            }
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                        .padding(.bottom, 94)
                        .foregroundStyle(.brown1)
                        
                        
                        if reports.count == 0 {
                            // MARK: nanti diganti chart kosong
                            VStack{
                                Text(AppLabel.noStatisticText)
                                    .font(.custom("Jua-Regular", size: 32))
                                    .foregroundStyle(.brownGuide)
                                    .padding()
                            }
                            .frame(maxHeight: 472)
                            
                        } else {
                            FocusChart(reports: self.reports, filterDateTime: $filterDateTime, strideFilter: self.strideFilter)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 20)
                        }
                    }
                    .background(in: RoundedRectangle(cornerRadius: 25), fillStyle: FillStyle())
                    .frame(width: 972, height: 442)
                    .gesture(DragGesture()
                        .onEnded({ value in
                            if selectedIndex == 0 {
                                let threshold: CGFloat = 50
                                if value.translation.width > threshold {
                                    withAnimation {
                                        currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
                                        self.reports = DataController.shared.fetchReportByDay(currentDate)
                                        self.focusAverage = averageFocus(reports: self.reports) ?? 0.0
                                    }
                                } else if value.translation.width < -threshold {
                                    withAnimation {
                                        currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
                                        self.reports = DataController.shared.fetchReportByDay(currentDate)
                                        self.focusAverage = averageFocus(reports: self.reports) ?? 0.0
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
        .onAppear{
            selectedIndex = 0
            currentDate = Date()
            self.reports = DataController.shared.fetchReportByDay(currentDate)
            self.focusAverage = averageFocus(reports: self.reports) ?? 0.0
        }
        .onChange(of: self.selectedIndex, perform: { index in
            if index == 0 {
                withAnimation {
                    self.reports = DataController.shared.fetchReportByDay(currentDate)
                    self.strideFilter = .hour
                    self.filterDateTime = .dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits)
                    self.focusAverage = averageFocus(reports: self.reports) ?? 0.0
                }
                
            }
            else if index == 1 {
                withAnimation {
                    self.reports = DataController.shared.fetchReportByWeek(currentDate)
                    self.strideFilter = .day
                    self.filterDateTime = .dateTime.weekday()
                    self.focusAverage = averageFocus(reports: self.reports) ?? 0.0
                }
            }
            else if index == 2 {
                withAnimation {
                    self.reports = DataController.shared.fetchReportByMonth(currentDate)
                    self.strideFilter = .day
                    self.filterDateTime = .dateTime.day()
                    self.focusAverage = averageFocus(reports: self.reports) ?? 0.0
                }
            }
        })
        .preferredColorScheme(.light)
    }
    
    
    
}


#Preview {
    StatisticViewSwift()
}
