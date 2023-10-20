//
//  GameView.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 18/10/23.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct GameView: View {
    var scene: SKScene
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    GameView(scene: HideAndSeekScene())
}
