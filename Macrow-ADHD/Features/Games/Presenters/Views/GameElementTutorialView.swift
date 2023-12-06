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
    //FIXME: for demo purpose deleted AppStorage property
    @AppStorage("isActive") private var isActive: Bool = true
    
    var currentGame: GameInfo
    let gameScene = GameElementTutorial(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    var body: some View {
        
        if !isActive {
            GameView(currentGame: currentGame)
        } else {
            ZStack {
                SpriteView(scene: gameScene)
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden()
                
                ThoughtBubble(text: AppLabel.GameElementTutorialView.bubbleTexts[idx], position: .left)
                    .position(CGPoint(x: UIScreen.main.bounds.width * 0.55, y: UIScreen.main.bounds.height * 0.31))
                    .opacity(!isPaused ? 1 : 0)
                
                TextButton(contentType: .next, buttonStyle: .lightBrown, buttonSize: .small) {
                    switch(idx) {
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
                                isPaused = false
                            }
                        }
                    case 4:
                        isActive = false
                    default:
                        idx += 1
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
