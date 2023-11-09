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
    var name: String
    var description: String
    var imageName: String
    var mainFocus: String
}
