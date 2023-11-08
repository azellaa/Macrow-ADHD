//
//  AppLabel.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/6/23.
//

import Foundation

struct AppLabel: Constants {
    static let statistic = "Statistic"
    static let focusAvg = "Focus Avg."
    static let noFocusValue = "-"
    static let statisticOptions = ["Day", "Week", "Month"]
    static let noStatisticText = "There’s no data recorded, try to play some games"
    static let home = "Home"
    static let play = "Play"
    static let next = "Next"
    static let previous = "Previous"
}

extension AppLabel {
    struct StatisticView {
        static let aboutText = "About:\nThis visualization shows data captured by the Neurosky device during gameplay, tracking the child's focus level over time. Monitoring focus and providing session details, also give a deeper understanding of what influences the child's concentration." 
    }
}
