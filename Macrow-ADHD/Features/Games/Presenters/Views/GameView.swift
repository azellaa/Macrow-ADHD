//
//  GameView.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 18/10/23.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct GameView: View{
    @Environment(\.presentationMode) var presentationMode
    @State var isEndGame: Bool = false
    @State var scene: SKScene = SKScene()
    var currentGame: GameInfo
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .navigationBarBackButtonHidden()
            
            TextButton(contentType: .home, buttonStyle: .lightBrown, buttonSize: .small) {
                NavigationUtil.popToRootView()
            }
            .position(CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height * 0.832))
            .opacity(!isEndGame ? 0 : 1)
        }
        .onAppear {
            if currentGame.name == "Hide and Seek" {
                #if targetEnvironment(simulator)
                scene = HideAndSeekWithHeadpiece(
                    size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height),
                    isEndGame: $isEndGame,
                    hideAndSeekLevel: .init(
                        name: currentGame.name,
                        levelEnum: .beginner
                    )
                )
                #else
                scene = HideAndSeekWithHeadpiece(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), isEndGame: $isEndGame,
                    hideAndSeekLevel: .init(
                         name: currentGame.name,
                         levelEnum: .beginner
                    )
                )
                #endif
            }
        }
    }

    func isEndGameOpen(_ hideAndSeekScene: HideAndSeekScene, isEndGame: Bool) {
        self.isEndGame = isEndGame
    }
}

#Preview {
    GameView(currentGame: GameInfo(currentGame: .hideAndSeek))
}
