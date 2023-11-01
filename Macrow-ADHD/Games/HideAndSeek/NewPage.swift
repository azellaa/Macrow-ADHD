//
//  NewPage.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 03/10/23.
//

import SpriteKit
import GameplayKit

class NewPage: SKScene, SKPhysicsContactDelegate {
    
    var progressBar = ProgressBar()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        scene?.size = view.bounds.size
        scene?.scaleMode = .aspectFill
        
        progressBar.getSceneFrame(sceneFrame: frame)
        progressBar.buildProgressBar()
        progressBar.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        addChild(progressBar)
        
        var count = 100
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if count <= 0 { timer.invalidate() }
            self.progressBar.updateProgressBar(CGFloat(count), timeLeft: "100", score: 10)
            
            count -= 1
        }
    }
}
