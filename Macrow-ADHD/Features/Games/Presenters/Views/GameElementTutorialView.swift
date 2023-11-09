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
    @State var isPaused: Bool = false
    @AppStorage("gameElementTutorialOpeneed") private var isActive: Bool = true
    
    var currentGame: GameInfo
    let gameScene = GameElementTutorial(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), text: "This bar shows your focus level")
    
    var texts: [String] = [
        "This bar shows your focus level",
        "If it’s in the red, the rabbit doesn’t want to appear",
        "If that happens, my cat will help you to regain focus",
        "You should follow and watch my cat",
        "Great, now let’s gather the rabbit!"
    ]
    
    var body: some View {
        
        if !isActive {
            GameView(currentGame: currentGame)
        } else {
            ZStack {
                SpriteView(scene: gameScene)
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden()
                
                TextButton(contentType: .next, buttonStyle: .brown, buttonSize: .small) {
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
                        isActive = false
                    default:
                        idx += 1
                        gameScene.nextTutorial(text: texts[idx])
                    }
                }
                .opacity(!isPaused ? 1 : 0)
                .position(CGPoint(x: UIScreen.main.bounds.width * 0.821, y: UIScreen.main.bounds.height * 0.887))
                .zIndex(30)
            }
            .navigationBarBackButtonHidden()
        }
        
    }
}
