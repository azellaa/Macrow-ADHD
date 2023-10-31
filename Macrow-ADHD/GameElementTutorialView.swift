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
        ZStack {
            SpriteView(scene: gameScene)
                .ignoresSafeArea()
                .navigationBarBackButtonHidden()
                .onTapGesture {
                    switch(idx) {
                    case 2:
                        idx += 1
                        gameScene.nextTutorial(text: texts[idx])
                    case 3:
                        if !isPaused {
                            gameScene.hideAll()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                gameScene.pauseTutorial()
                                isPaused = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                                gameScene.removePause()
                                idx = 4
                                gameScene.nextTutorial(text: texts[idx])
                            }
                        }
                    case 4:
                        isActive = true
                    default:
                        idx += 1
                        gameScene.nextTutorial(text: texts[idx])
                    }
                }
                .background (NavigationLink(
                    destination: GameView(scene: currentGame.destination),
                    isActive: $isActive) {
                    EmptyView()
                })
        }
    }
}
