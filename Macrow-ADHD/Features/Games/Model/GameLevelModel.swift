//
//  GameModel.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/19/23.
//

import Foundation

struct GameLevelModel {
    var name: String
    var levelEnum: LevelEnum
    var levelModel: HideAndSeekLevelModel {
        switch levelEnum {
        case .beginner:
            HideAndSeekLevelModel(
                intRepresentation: 1,
                levelDuration: 120,
                spawnInteval: 2,
                maximumSpawn: 1,
                foxRatio: 1,
                rabbitRatio: 5
            )
        case .intermediate:
            HideAndSeekLevelModel(
                intRepresentation: 2,
                levelDuration: 480,
                spawnInteval: 1.5,
                maximumSpawn: 3,
                foxRatio: 2,
                rabbitRatio: 3
            )
        case .advanced:
            HideAndSeekLevelModel(
                intRepresentation: 3,
                levelDuration: 600,
                spawnInteval: 1,
                maximumSpawn: 4,
                foxRatio: 3,
                rabbitRatio: 2
            )
        }
    }
}

extension GameLevelModel {
    enum LevelEnum {
        case beginner
        case intermediate
        case advanced
    }
    struct HideAndSeekLevelModel {
        var intRepresentation: Int
        var levelDuration: Int
        var spawnInteval: Double
        var maximumSpawn: Int
        var foxRatio: Int
        var rabbitRatio: Int
    }
}


