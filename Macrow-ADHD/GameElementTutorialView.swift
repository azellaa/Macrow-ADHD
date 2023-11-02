//
//  GameElementTutorialView.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 30/10/23.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct GameElementTutorialView: View {
    @State var idx: Int = 0
    @State var isActive: Bool = false
    @State var isPaused: Bool = false
    
    var currentGame: GameInfo
    var width: CGFloat
    var height: CGFloat
    let gameScene = GameElementTutorial(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), text: "This bar shows your focus level")
    
    var texts: [String] = [
        "This bar shows your focus level",
        "If it’s in the red, the rabbit doesn’t want to appear",
        "If that happens, my cat will help you to regain focus",
        "You should follow and watch my cat",
        "Great, now let’s gather the rabbit!"
    ]
    
    var body: some View {
        if isActive {
            GameView(scene: currentGame.destination)
        } else {
            ZStack {
                SpriteView(scene: gameScene)
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden()
                
                TouchButton(padding: .constant(0), normalImageName: "buttonNextNotPressed",
                            pressedImageName: "buttonNextPressed",
                            action: {
                    switch(idx) {
                    case 2:
                        idx += 1
                        gameScene.nextTutorial(text: texts[idx])
                    case 3:
                        if !isPaused {
                            gameScene.hideAll()
                            isPaused = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                gameScene.pauseTutorial()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 13) {
                                gameScene.removePause()
                                idx = 4
                                gameScene.nextTutorial(text: texts[idx])
                                isPaused = false
                            }
                        }
                    case 4:
                        isActive = true
                    default:
                        idx += 1
                        gameScene.nextTutorial(text: texts[idx])
                    }
                })
                .opacity(!isPaused ? 1 : 0)
                .position(CGPoint(x: width * 0.82, y: height * 0.91))
                .zIndex(30)
            }
            .navigationBarBackButtonHidden()
        }

    }
}
