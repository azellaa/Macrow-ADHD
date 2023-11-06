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


class GameOverPage: SKNode {

    var timerEnded = false
    var endImage: SKSpriteNode!
    private var sceneFrame = CGRect()
    let sharedRabbitCount = GameData.rabbitCount
    
    override init(){
        super.init()
    }
    
    required init(sceneFrame: CGRect)
     {
        super.init()
        self.sceneFrame = sceneFrame
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            congratsLabel.text = "Congratulations!"
            congratsLabel.position = CGPoint(x: frame.width / 2, y: frame.height + 120 )
            congratsLabel.fontColor = SKColor(named: "cream2Color")
            congratsLabel.zPosition = 2
            addChild(congratsLabel)
            
            let scoreLabel = SKLabelNode(fontNamed: "Jua-Regular")
            scoreLabel.fontSize = 64
            scoreLabel.text = "Your Score"
            scoreLabel.fontColor = SKColor(named: "cream2Color")
            scoreLabel.position = CGPoint(x: frame.width / 2, y: frame.height / 2 )
            scoreLabel.zPosition = 2
            addChild(scoreLabel)
            
            let starBg = SKSpriteNode(imageNamed: "starBg")
            starBg.position = CGPoint(x: frame.width / 2, y: frame.height / 2 - 100)
            starBg.size = CGSize(width: 451, height: 157)
            starBg.zPosition = 2
            addChild(starBg)
            
            let star = SKSpriteNode(imageNamed: "star")
            star.position = CGPoint(x: frame.width / 2 - 50 , y: frame.height / 2 - 95)
            star.zPosition = 3
            addChild(star)
            

            // Create the outline label
            let outlineLabel = SKLabelNode(fontNamed: "Jua-Regular")
            outlineLabel.fontSize = congratsLabel.fontSize
            outlineLabel.text = congratsLabel.text
            outlineLabel.fontColor = SKColor(named: "cream2Color")
            outlineLabel.position = CGPoint(x: congratsLabel.position.x + 2, y: congratsLabel.position.y )
            outlineLabel.zPosition = 1
            addChild(outlineLabel)

            
            // Create and add a label to display the rabbit count
            let starLabel = SKLabelNode(fontNamed: "Jua-Regular")
            starLabel.fontSize = 96
            starLabel.text = "\(sharedRabbitCount)"
            starLabel.fontColor = SKColor(named: "cream2Color")
            starLabel.position = CGPoint(x: frame.width / 2 + 50, y: frame.height / 2 - 140)
            starLabel.zPosition = 2
            addChild(starLabel)
            
            let homeButton = SKSpriteNode(imageNamed: "homeButton")
            homeButton.name = "homeButton"
            homeButton.position = CGPoint(x: frame.width / 2, y: frame.height / 2 - 280)
            homeButton.zPosition = 2
            addChild(homeButton)
            
        }
    }
    
    
    func returnToApp() {
        if let skView = self.scene?.view as? SKView, let window = skView.window {
            let homeView = NavigationStack {
                HomeView()
            } // Assuming HomeView is your SwiftUI view
            let hostingController = UIHostingController(rootView: homeView)
            window.rootViewController = hostingController
        }
    }



    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNodes = nodes(at: location)

            for node in touchedNodes {
                if node.name == "homeButton" {
                    print("Home button tapped")
                    returnToApp()
                }
            }
        }
    }



}


