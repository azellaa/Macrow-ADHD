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
    
    private var circleOverlay = SKShapeNode()
    private var focusCatNoHand = SKSpriteNode(imageNamed: "focusCatNoHand")
    private var focusCatHand = SKSpriteNode(imageNamed: "focusCatHand")
    
    private var sceneNode = SKSpriteNode()
    
    var isShowing = false
    lazy var currentScene: SKScene = self.scene!
    private var moveTransform = CGAffineTransform(translationX: 1.0, y: 1.0)
    private var hasCapturedScreen = false
    override init() {
        super.init()
    }
    
    required init(sceneFrame: CGRect) {
        super.init()
        self.sceneFrame = sceneFrame
        
        blackAlphaBackground.size = CGSize(width: sceneFrame.width, height: sceneFrame.height)
        blackAlphaBackground.color = .black
        
        cropNode.zPosition = 2 // Ensure it's above other nodes
        circleOverlay = SKShapeNode(ellipseOf: CGSize(width: 140, height: 140))
        circleOverlay.fillColor = .white
        circleOverlay.strokeColor = .clear
        
        focusCatNoHand.setScale(0.41)
        
        focusCatHand.setScale(0.95)
        focusCatHand.zPosition = 2
        
        popUpText.text = "Follow Me!"
        popUpText.fontSize = 64
        popUpText.zPosition = 25
        
        startingPosition()
        addChild(blackAlphaBackground)
        addChild(cropNode)
        addChild(focusCatHand)
        addChild(popUpText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startingPosition() {
        focusCatNoHand.removeAllActions()
        blackAlphaBackground.removeAllActions()
        focusCatNoHand.removeAllActions()
        popUpText.removeAllActions()
        blackAlphaBackground.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height / 2)
        circleOverlay.position = CGPoint(x: self.sceneFrame.midX, y: self.sceneFrame.midY)
        focusCatNoHand.position = CGPoint(x: circleOverlay.position.x, y: sceneFrame.height * 0.2 )
        focusCatHand.position = CGPoint(x: circleOverlay.position.x, y: circleOverlay.position.y - focusCatNoHand.frame.height * 0.8)
        popUpText.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height / 2 + 31)
        
        blackAlphaBackground.alpha = 0.5
        focusCatNoHand.alpha = 0
        focusCatHand.alpha = 0
        popUpText.alpha = 0
    }
    
    func startShowPause(_ currentScene: SKScene) {
        
        if !hasCapturedScreen, let capturedNode = ScreenCapture.captureScreenAsSpriteNode(scene: currentScene) {
            hasCapturedScreen = true
            sceneNode = capturedNode
            sceneNode.position = CGPoint(x: sceneFrame.midX, y: sceneFrame.midY)
            cropNode.maskNode = circleOverlay
            cropNode.addChild(sceneNode)
            cropNode.addChild(focusCatNoHand)
            focusCatNoHand.alpha = 0
        }
        circleOverlay.position = CGPoint(x: self.sceneFrame.midX, y: self.sceneFrame.midY)
        let initialScale: CGFloat = 10 // You can adjust the scale as needed
        circleOverlay.setScale(initialScale)
        let scaleAction = SKAction.scale(to: 1.0, duration: 1) // Adjust duration as needed
        // After the scale animation, start the bounce animation
        let sequence = SKAction.sequence([
            scaleAction,
        ])
        
        // Run the sequence on the circleOverlay
        if !isShowing {
            let circleOverlayPosition = circleOverlay.position
            circleOverlay.run(sequence)
            self.run(SKAction.sequence([
                SKAction.wait(forDuration: 1),
                SKAction.run { [self] in
                    self.focusCatNoHand.run(SKAction.fadeIn(withDuration: 1))
                    self.focusCatNoHand.run(SKAction.move(to: CGPoint(x: circleOverlayPosition.x, y: circleOverlayPosition.y - 14), duration: 1))
                },
                SKAction.wait(forDuration: 1),
                SKAction.run { [self] in
                    focusCatNoHand.removeFromParent()
                    focusCatNoHand.zPosition = 5
                    self.addChild(focusCatNoHand)
                    self.focusCatNoHand.run(SKAction.move(to: CGPoint(x: circleOverlayPosition.x, y: circleOverlayPosition.y - 15), duration: 0.2))
                },
                SKAction.run { [self] in
                    self.focusCatHand.run(SKAction.fadeIn(withDuration: 0.5))
                    self.focusCatHand.run(SKAction.move(to: CGPoint(x: circleOverlayPosition.x - 3, y: circleOverlayPosition.y - focusCatNoHand.frame.height * 0.5), duration: 0.5))
                    self.popUpText.run(SKAction.fadeIn(withDuration: 0.3))
                },
                SKAction.wait(forDuration: 3),
                SKAction.run {
                    self.focusCatNoHand.removeAllActions()
                    self.focusCatHand.removeAllActions()
                    self.popUpText.run(SKAction.fadeOut(withDuration: 0.3))
                    self.isShowing = true
                }
            ]))
        }
        
        // Reset the focusCat position
        
    }
    
    func stopShowPause() {
        self.removeAllActions()
        sceneNode.removeFromParent()
        focusCatNoHand.removeFromParent()
        startingPosition()
        
        self.isShowing = false
        self.hasCapturedScreen = false
    }
    
    
    func update(_ currentTime: TimeInterval) {
        //        startCircleMovement()
        if isShowing {
            startBounce()
        }
    }
    
    //    func captureScreenAsSpriteNode(scene: SKScene) -> SKSpriteNode? {
    //        // 1. Capture the current screen as a UIImage
    //        guard let view = scene.view else {
    //            return nil
    //        }
    //
    //        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
    //        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    //        guard let capturedImage = UIGraphicsGetImageFromCurrentImageContext() else {
    //            UIGraphicsEndImageContext()
    //            return nil
    //        }
    //        UIGraphicsEndImageContext()
    //
    //        // 2. Create an SKTexture from the UIImage
    //        let texture = SKTexture(image: capturedImage)
    //
    //        // 3. Create an SKSpriteNode with the SKTexture
    //        let spriteNode = SKSpriteNode(texture: texture)
    //
    //        // Optionally, you can set the position, scale, and other properties of the spriteNode here
    //        spriteNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
    //
    //        return spriteNode
    //    }
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
        focusCatHand.position = CGPoint(x:  circleOverlay.position.x - 3, y:  circleOverlay.position.y - focusCatNoHand.frame.height * 0.5)
        focusCatNoHand.position = CGPoint(x: circleOverlay.position.x, y: circleOverlay.position.y - 15)
    }
    
}
