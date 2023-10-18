//
//  AttentionPopup.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 10/4/23.
//

import Foundation
import SpriteKit
class AttentionPopup: SKNode {
    private var sceneFrame = CGRect()
    public var popUpText = SKLabelNode(fontNamed: "Jua-Regular")
    private var blackAlphaBackground = SKSpriteNode()
    private let cropNode = SKCropNode()
    
    private var bgOverlay = BackgroundHideAndSeek()
    private var circleOverlay = SKShapeNode()
    private var focusCat = SKSpriteNode(imageNamed: "focusCat")
    private var focusCatNoHand = SKSpriteNode(imageNamed: "focusCatNoHand")
    private var focusCatHand = SKSpriteNode(imageNamed: "focusCatHand")
    
    var isShowing = false
    private var moveTransform = CGAffineTransform(translationX: 1.0, y: 1.0)
    override init() {
        super.init()
    }
    
    required init(sceneFrame: CGRect) {
        super.init()
        self.sceneFrame = sceneFrame
        
        blackAlphaBackground.size = CGSize(width: sceneFrame.width, height: sceneFrame.height)
        blackAlphaBackground.color = .black
        blackAlphaBackground.alpha = 0.5
        blackAlphaBackground.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height / 2)
        addChild(blackAlphaBackground)
        
        cropNode.zPosition = 2 // Ensure it's above other nodes
        circleOverlay = SKShapeNode(ellipseOf: CGSize(width: 140, height: 140))
        circleOverlay.position = CGPoint(x: self.sceneFrame.midX, y: self.sceneFrame.midY)
        circleOverlay.fillColor = .white
        //        circleOverlay.blendMode = .alpha
        circleOverlay.strokeColor = .clear
        
        
        bgOverlay.getSceneFrame(sceneFrame: sceneFrame)
        bgOverlay.addBackground()
        bgOverlay.position = CGPoint(x: 0, y: 0)
        
        cropNode.maskNode = circleOverlay
        cropNode.addChild(bgOverlay)
        
        addChild(cropNode)
        
        //        let focusCat = SKSpriteNode(imageNamed: "focusCat")
        //        focusCat.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        focusCat.position = circleOverlay.position
        focusCat.zPosition = 5
        focusCat.alpha = 0
        addChild(focusCat)
        
        focusCatNoHand.position = CGPoint(x: circleOverlay.position.x, y: circleOverlay.position.y - focusCatNoHand.size.height)
        //        focusCatNoHand.zPosition = 1
        focusCatNoHand.alpha = 0
        cropNode.addChild(focusCatNoHand)
        
        focusCatHand.position = CGPoint(x: circleOverlay.position.x, y: circleOverlay.position.y - focusCatNoHand.frame.height/2)
        focusCatHand.zPosition = 5
        focusCatHand.alpha = 0
        addChild(focusCatHand)
        
        popUpText.text = "Follow Me!"
        popUpText.fontSize = 64
        popUpText.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height / 2 + 31)
        popUpText.alpha = 0
        popUpText.zPosition = 25
        addChild(popUpText)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startShowPause() {
        // Reset the circleOverlay size to a larger initial size
        circleOverlay.position = CGPoint(x: self.sceneFrame.midX, y: self.sceneFrame.midY)
        focusCat.position = CGPoint(x: circleOverlay.position.x, y: circleOverlay.position.y - 25)
        let initialScale: CGFloat = 10 // You can adjust the scale as needed
        circleOverlay.setScale(initialScale)
        let scaleAction = SKAction.scale(to: 1.0, duration: 1) // Adjust duration as needed
        // After the scale animation, start the bounce animation
        let sequence = SKAction.sequence([
            scaleAction,
            SKAction.wait(forDuration: 3),
            SKAction.run { [self] in
                self.focusCatNoHand.run(SKAction.fadeIn(withDuration: 1))
                self.focusCatNoHand.run(SKAction.move(to: CGPoint(x: circleOverlay.position.x, y: circleOverlay.position.y - 25), duration: 0.5))
                
            },
            SKAction.wait(forDuration: 1.5),
            SKAction.run { [self] in
                self.focusCatHand.run(SKAction.fadeIn(withDuration: 1))
            },
            SKAction.wait(forDuration: 1),
            
            SKAction.run { [self] in
                self.focusCatNoHand.run(SKAction.fadeOut(withDuration: 0.5))
                self.focusCat.run(SKAction.fadeIn(withDuration: 0.5))
                self.focusCatHand.run(SKAction.fadeOut(withDuration: 0.5))
            },
            SKAction.wait(forDuration: 2),
            SKAction.run { [ self] in
                //            self?.startBounce()
                self.popUpText.run(SKAction.fadeIn(withDuration: 0.3))
            },
//            SKAction.wait(forDuration: 3),

        ])
        
        // Run the sequence on the circleOverlay
        if !isShowing {
            circleOverlay.run(sequence) {
                SKAction.run {
                    self.popUpText.run(SKAction.fadeOut(withDuration: 0.3))
                }
                self.isShowing = true
            }
        }
        
        // Reset the focusCat position
    }
    
    func stopShowPause() {
        self.isShowing = false
    }
    
    
    func update(_ currentTime: TimeInterval) {
        //        startCircleMovement()
        if isShowing {
            startBounce()
        }
    }
    
    
    func startBounce() {
        let currentFrame = circleOverlay.calculateAccumulatedFrame()
        
        // Top bound
        if currentFrame.maxY >= self.sceneFrame.maxY {
            moveTransform.ty = -1.0
        }
        
        // Right bound
        if currentFrame.maxX >= self.sceneFrame.maxX {
            moveTransform.tx = -1.0
        }
        
        // Bottom bound
        if currentFrame.minY <= self.sceneFrame.minY {
            moveTransform.ty = 1.0
        }
        
        // Left bound
        if currentFrame.minX <= self.sceneFrame.minX {
            moveTransform.tx = 1.0
        }
        
        // Update the node's position by applying the transform
        circleOverlay.position = circleOverlay.position.applying(moveTransform)
        focusCat.position = focusCat.position.applying(moveTransform)
    }
    
}

