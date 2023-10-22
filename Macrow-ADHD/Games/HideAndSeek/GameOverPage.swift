//
//  NewPage.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 03/10/23.
//

import SpriteKit
import GameplayKit


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
            endImage.zPosition = 1 // Ensure it's in front of other nodes
            addChild(endImage)
            
            // Create and add a label to display the rabbit count
            // Now, you can access the rabbitCount property here and display it
                  let rabbitCountLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
                  rabbitCountLabel.fontSize = 36
                  rabbitCountLabel.text = "You saved \(sharedRabbitCount) rabbits"
                  rabbitCountLabel.position = CGPoint(x: frame.width / 2, y: frame.height / 2 - 190) // Adjust position as needed
                  rabbitCountLabel.zPosition = 2 // Ensure it's in front of other nodes
                  addChild(rabbitCountLabel)
              }
    }
}
