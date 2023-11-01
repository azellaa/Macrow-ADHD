//
//  NewPage.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 03/10/23.
//

import SpriteKit
import GameplayKit
import UIKit
import SwiftUI


class GameOverPage: SKScene, SKPhysicsContactDelegate {
    
    //    var progressBar = ProgressBar()
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
            print("Showing end image") // Debugging statement
            endImage = SKSpriteNode(imageNamed: "Popup4")
            endImage.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            endImage.zPosition = 1
            addChild(endImage)
            
            // Create the main label (text label)
            let congratsLabel = SKLabelNode(fontNamed: "Jua-Regular")
            congratsLabel.fontSize = 48
            congratsLabel.text = "CONGRATULATIONS!"
            congratsLabel.position = CGPoint(x: frame.width / 2, y: frame.height / 2 - 130)
            congratsLabel.zPosition = 2
            addChild(congratsLabel)

            // Create the outline label
            let outlineLabel = SKLabelNode(fontNamed: "Jua-Regular")
            outlineLabel.fontSize = congratsLabel.fontSize
            outlineLabel.text = congratsLabel.text
            outlineLabel.position = CGPoint(x: congratsLabel.position.x + 2, y: congratsLabel.position.y )
            outlineLabel.zPosition = 1
            outlineLabel.fontColor = .white
            addChild(outlineLabel)

            
            // Create and add a label to display the rabbit count
            let rabbitCountLabel = SKLabelNode(fontNamed: "Jua-Regular")
            rabbitCountLabel.fontSize = 36
            rabbitCountLabel.text = "You saved \(sharedRabbitCount) rabbits"
            rabbitCountLabel.position = CGPoint(x: frame.width / 2 - 3, y: frame.height / 2 - 175)
            rabbitCountLabel.zPosition = 2
            addChild(rabbitCountLabel)
            
            let homeButton = SKSpriteNode(imageNamed: "homeButton")
            homeButton.name = "homeButton"
            homeButton.position = CGPoint(x: frame.width / 2, y: frame.height / 2 - 240)
            homeButton.zPosition = 2
            addChild(homeButton)
        }
    }
    
    
    func returnToApp() {
        if let window = view?.window {
            let appView = ContentView()
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
