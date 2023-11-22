//
//  ResourcePath.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/6/23.
//

import Foundation

struct ResourcePath: Constants {
    static let mainBackground = "MainBackground"
    static let hideAndSeekBackground = "Hide And Seek Background"
    static let willHoldingBagDefault = "Will-Holding Bag-Default"
    static let willSmiling = "Will-Smiling"
    static let willDefault = "Will-Default"
    static let fox = "Fox"
    static let rabbit = "Rabbit"
    static let connected = "Connected"
    static let connecting1 = "Connecting-1"
    static let connecting2 = "Connecting-2"
    static let connecting3 = "Connecting-3"
    static let notConnected = "Not Connected"
    static let disconnectedPopUp = "disconnectedPopUp"
    static let backBrown = "Back, Brown"
    static let backWhite = "Back, White"
    static let closeBrown = "Close, Brown"
    static let closeWhite = "Close, White"
    static let guideBrown = "Guide, Brown"
    static let guideWhite = "Guide, White"
    static let homeBrown = "Home, Brown"
    static let homeWhite = "Home, White"
    static let nextWhite = "Next, White"
    static let nextBrown = "Next, Brown"
    static let playWhite = "Play, White"
    static let playBrown = "Play, Brown"
    static let prevBrown = "Previous, Brown"
    static let prevWhite = "Previous, White"
    static let shareBrown = "Share, Brown"
    static let shareWhite = "Share, White"
    static let statisticBrown = "Statistic, Brown"
    static let statisticWhite = "Statistic, White"
    
}
//MARK: HomeView
extension ResourcePath {
    struct HomeView {
        static let homeBackground = ["homeHideBg", "homeConnectBg"]
        static let homeHideAndSeek = "homeHideAndSeek"
        static let homeConnectNumber = "homeConnectNumber"
    }
}

//MARK: IntroductionView
extension ResourcePath {
    struct IntroductionView {
        struct HideAndSeek {
            static let background = "HideNSeekIntroductionBackground"
//            static let subheadingBackgroundColor = "SubheadingIntroductionBackgroundColor"
        }
        
        struct Game2 {
            
        }
    }
}

//MARK: Guide View
extension ResourcePath {
    struct GuideView {
        static let nonInteractableContainer = "Non-Interactable Container"
        static let bluetoothCream = "Bluetooth, Cream"
        static let placeCream = "Place, Cream"
        static let sensorCream = "Sensor, Cream"
        static let headCream = "Head, Cream"
        static let shadowRectangleBrown = "Shadow Rectangle, Brown"
        static let onCream = "On, Cream"
    }
}

//MARK: - HideAndSeekBackground
extension ResourcePath {
    struct HideAndSeekBackground {
        static let land1 = "Land 1"
        static let land2 = "Land 2"
        static let land3 = "Land 3"
        static let land4 = "Land 4"
        static let background = "Background"
        static let bushLeft = "Bush Left"
        static let bushRight = "Bush Right"
        static let bushBack = "Bush Back"
        static let rocks = "Rocks"
        static let wood = "Wood Log"
    }
}

//MARK: - SoundEffect
extension ResourcePath {
    struct SoundEffect {
        static let buttonSound = "Button Sound"
        static let gainStarSound = "Gain Star Sound"
        static let loseStarSound = "Lose Star Sound"

    }
}

//MARK: - DeviceTutorial
extension ResourcePath {
    struct DeviceTutorial {
        struct willHalfBody {
            static let willHalfBody1 = "Smiling=No, With Cat=No, Holding Bag=Yes, View=Half Body"
            static let willHalfBody2 = "Smiling=Yes, With Cat=Yes, Holding Bag=No, View=Half Body"
            static let willHalfBody3 = "Smiling=No, With Cat=Yes, Holding Bag=No, View=Half Body"
            static let willHalfBody4 = "Smiling=No, With Cat=Yes, Holding Bag=Yes, View=Half Body"
        }
        
        struct device {
            static let deviceDefault = "Device-Default"
            static let deviceDetailOn = "Device-Detail On"
            static let deviceDetailOff = "Device-Detail Off"
            static let deviceDetailSensor = "Device-Detail Sensor"
            static let deviceDetailEarclip = "Device-Detail Earclip"
        }
    }
}

//MARK: HideAndSeekScene
extension ResourcePath {
    struct HideAndSeekScene {
        static let rabbitTap = "Rabbit_Tap"
        static let rabbitHide = "Rabbit_Hide"
        static let foxSeek = "Fox_Seek"
        static let foxTap = "Fox_Tap"
        static let disconnectedPopUp = "disconnectedPopUp"
        
        struct Sounds {
            static let backgroundMusic = "Jungle Song"
        }
    }
}

//MARK: - Hide&SeekIntroduction
extension ResourcePath {
    struct HideAndSeekIntroduction {
        static let starIcon = "starIcon"
    }
}
