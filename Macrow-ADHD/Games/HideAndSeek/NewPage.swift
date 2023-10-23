//
//  NewPage.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 03/10/23.
//

import SpriteKit
import GameplayKit
import SwiftUI
import UIKit

class NewPage: SKScene, SKPhysicsContactDelegate {
    
    var progressBar = ProgressBar()
    var timerEnded = false
    var endImage: SKSpriteNode!
    // Access the shared rabbitCount
    let sharedRabbitCount = GameData.rabbitCount
    
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        
        scene?.size = view.bounds.size
        scene?.scaleMode = .aspectFill
        
        showEndImage()
        
        var count = 100
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if count <= 0 {
                timer.invalidate()
                self.timerEnded = true
                self.showEndImage()
            } else {
                self.showEndImage()
            }
            
            count -= 1
        }
    }
    
    
    func showEndImage() {
        if endImage == nil {
            print("Showing end image")
            endImage = SKSpriteNode(imageNamed: "gameOverBasePopUp")
            endImage.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            endImage.zPosition = 1
            addChild(endImage)
            
            let rabbitCountLabel = SKLabelNode(fontNamed: "Jua-Regular")
            rabbitCountLabel.fontSize = 36
            rabbitCountLabel.text = "You saved \(sharedRabbitCount) rabbits"
            rabbitCountLabel.position = CGPoint(x: frame.width / 2, y: frame.height / 2 - 160)
            rabbitCountLabel.zPosition = 2 // Ensure it's in front of other nodes
            addChild(rabbitCountLabel)
            
            let homeButton = SKSpriteNode(imageNamed: "homeButton")
            homeButton.name = "homeButton"
            homeButton.position = CGPoint(x: frame.width / 2, y: frame.height / 2 - 220)
            homeButton.zPosition = 2
            addChild(homeButton)
            
        }
    }
    
    @objc func homeButtonTapped() {
        returnToApp()
    }
    
    func returnToApp() {
        if let window = view?.window {
            let appView = Homepage()
            let controller = UIHostingController(rootView: appView)
            window.rootViewController = controller
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let node = self.atPoint(location) as? SKSpriteNode, node.name == "homeButton" {
                returnToApp()
            }
        }
    }
}
