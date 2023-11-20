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
    static let headpieceConnected = "headpieceLogo"
    static let headpieceDisconnected = "headpieceDisconnect"
    static let headpiece1Bar = "headpiece1Bar"
    static let headpiece2Bar = "headpiece2Bar"
    static let headpiece3Bar = "headpiece3Bar"
    
}
//MARK: HomeView
extension ResourcePath {
    struct HomeView {
        static let hideAndSeekHomeBackground = "homeBg"
        static let homeHideAndSeek = "homeHideAndSeek"
    }
}

//MARK: IntroductionView
extension ResourcePath {
    struct IntroductionView {
        struct HideAndSeek {
            static let background = "HideNSeekIntroductionBackground"
            static let subheadingBackgroundColor = "SubheadingIntroductionBackgroundColor"
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
