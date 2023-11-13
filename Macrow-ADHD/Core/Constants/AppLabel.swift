//
//  AppLabel.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/6/23.
//

import Foundation

struct AppLabel: Constants {
    static let appName = "Will's Storyland"
    static let appNameLine1 = "Will's"
    static let appNameLine2 = "Storyland"
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

//MARK: HomeView
extension AppLabel {
    struct HomeView {
        static let game1Name = "Hide and Seek"
        static let game1Description = "This game will be going on for 10 minutes. The purpose of this game is to tap the rabbits and ignore the fox. \n \nThis game will teach child to be patient and learn to ignore distraction. This game will be paused when child lose focus. and to continue the game, the child must learn to regain focus."
        static let game1MainFocus = "Focus    |    Waiting    |    Ignore Distraction"
    }
}

//MARK: IntroductionView
extension AppLabel {
    struct IntroductionView {
        struct HideAndSeek {
            static let name = "Hide and Seek"
            static let subheading = ["Patience", "Selective Focus"]
            static let description = "On his way in the forest, Will finds a rabbit that needs to hide from the fox. To safe the rabbit, you need to keep the rabbit hidden from the sly fox."
            static let level1 = "Beginner"
            static let level2 = "Intermediate"
            static let level3 = "Advanced"
        }
        
        struct Game2 {
            
        }
    }
}
extension AppLabel {
    struct StatisticView {
        static let aboutText = "About:\nThis visualization shows data captured by the Neurosky device during gameplay, tracking the child's focus level over time. Monitoring focus and providing session details, also give a deeper understanding of what influences the child's concentration." 
        static let rabbitCount = "Rabbit Count"
        static let foxCount = "Fox Count"
        static let pauseCount = "Pause Count"
        static let accumulation = "Accumulation"
        static let highestFocus = "Highest Focus"
        static let lowestFocus = "Lowest Focus"
        static let averageFocus = "Average Focus"
    }
}
// MARK: Guide view
extension AppLabel {
    struct GuideView {
        static let guide = "Guide"
        
        struct HeadpieceLabel {
            static let notConnectedLabel = "Not Connected"
            static let connecting1Label = "Poor Signal"
            static let connecting2Label = "Weak Signal"
            static let connecting3Label = "Connecting"
            static let connectedLabel = "Connected"
        }
        
        struct HeadpieceInfo {
            static let notConnectedInfo = "Device is not connected yet"
            static let connecting1Info = "Attempting to establish a connection"
            static let connecting2Info = "Signal is relatively weak. Device attempting for stronger connection"
            static let connecting3Info = "Device may have unstable connection. Make sure device is securely attached for more stable connection"
            static let connectedInfo = "Device is successfully established a connection"
        }
        
        struct IconLabel {
            static let onLabel = "Make sure the device is turned on"
            static let bluetoothLabel = "Try to reset Bluetooth"
            static let placeLabel = "Try to move to other place"
            static let sensorLabel = "Ensure the sensor is well attached"
            static let headLabel = "Avoid too much head movements"
        }
    }
}
