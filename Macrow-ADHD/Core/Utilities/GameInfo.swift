//
//  gameInfo.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 19/10/23.
//

import SwiftUI
import SpriteKit

struct GameInfo: Identifiable {
    let id = UUID()
    var currentGame: GameInfoEnum
    var name: String
    var description: String
    var imageName: String
    var mainFocus: [String]
    var isLocked: Bool
    var gameIntroBg: String
    
    init(currentGame: GameInfoEnum) {
        self.currentGame = currentGame
        switch currentGame {
        case .hideAndSeek:
            name = AppLabel.HomeView.game1Name
            description = AppLabel.HomeView.game1Description
            imageName = ResourcePath.HomeView.homeHideAndSeek
            mainFocus = AppLabel.HomeView.game1MainFocus
            gameIntroBg = ResourcePath.IntroductionView.HideAndSeek.background
            isLocked = false
        case .connectNumber:
            name = AppLabel.HomeView.game2Name
            description = AppLabel.HomeView.game2Description
            imageName = ResourcePath.HomeView.homeConnectNumber
            mainFocus = AppLabel.HomeView.game2MainFocus
            gameIntroBg = ""
            isLocked = true
        }
    }
}

extension GameInfo {
    enum GameInfoEnum {
        case hideAndSeek
        case connectNumber
    }
}
