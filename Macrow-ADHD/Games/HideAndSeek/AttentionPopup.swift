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
    public var popUpText = SKLabelNode(text: "Paused")
    private var blackAlphaBackground = SKSpriteNode()
    private let cropNode = SKCropNode()
    
    private var bgOverlay = BackgroundHideAndSeek()
    private var circleOverlay = SKShapeNode()
    private var focusCat = SKSpriteNode(imageNamed: "focusCat")
    
    
    var moveRate = TimeInterval(2)
    var lastMove = TimeInterval(0)
    
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
        circleOverlay = SKShapeNode(ellipseIn: CGRect(origin: CGPoint(x: sceneFrame.width * 0.5 , y: sceneFrame.height * 0.5), size: CGSize(width: 140, height: 140)))
        circleOverlay.position = CGPoint(x: 0 , y: 0)
        circleOverlay.fillColor = .white
//        circleOverlay.blendMode = .alpha
        circleOverlay.strokeColor = .clear
        
        cropNode.scene?.anchorPoint = CGPoint(x: 0, y: 0)
        
        bgOverlay.getSceneFrame(sceneFrame: sceneFrame)
        bgOverlay.addBackground()
        bgOverlay.position = CGPoint(x: 0, y: 0)
        
        cropNode.maskNode = circleOverlay
        cropNode.addChild(bgOverlay)
        
        addChild(cropNode)
        
//        let focusCat = SKSpriteNode(imageNamed: "focusCat")
        focusCat.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        focusCat.position = CGPoint(x: circleOverlay.position.x + self.sceneFrame.width/2 + focusCat.frame.size.width/2, y: circleOverlay.position.y + self.sceneFrame.height/2 + focusCat.frame.size.height/2)
        focusCat.zPosition = 5
        addChild(focusCat)
        
        
        
//        popUpText.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height / 2)
//        popUpText.zPosition = 25
//        addChild(popUpText)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateMaskNode(from mask:SKNode) -> SKNode
    {
        var returningNode : SKNode!
        autoreleasepool
        {
            let view = SKView()
            //First let's flatten the node
            let texture = view.texture(from: mask)
            let node = SKSpriteNode(texture:texture)
            //Next apply the shader to the flattened node to allow for color swapping
            node.shader = SKShader(fileNamed: "shader.fsh")
            let texture2 = view.texture(from: node)
            returningNode = SKSpriteNode(texture:texture2)

        }
        return returningNode
    }
    
    func update(_ currentTime: TimeInterval) {
        
//        let randomX = CGFloat.random(in: -(self.sceneFrame.width/2)...self.sceneFrame.width/2)
//        let randomY = CGFloat.random(in: -(self.sceneFrame.height/2)...self.sceneFrame.height/2)
//        
//        circleOverlay.position = CGPoint(x: randomX, y: randomY)
        startCircleMovement()
        lastMove = CACurrentMediaTime()
    }
    
    func startCircleMovement() {
        let randomX = CGFloat.random(in: -(self.sceneFrame.width/2)...self.sceneFrame.width/2)
        let randomY = CGFloat.random(in: -(self.sceneFrame.height/2)...self.sceneFrame.height/2)
        let newPosition = CGPoint(x: randomX, y: randomY)
        
        let moveAction = SKAction.move(to: newPosition, duration: moveRate)
        
        // Add an optional completion block to perform actions after the animation completes
        let completionAction = SKAction.run {
            // Animation has completed, you can perform additional actions here if needed
        }
        
        let sequence = SKAction.sequence([moveAction, completionAction])
        
        // Run the sequence on the circleOverlay
        circleOverlay.run(sequence)
        focusCat.run(SKAction.move(to: CGPoint(x: randomX + self.sceneFrame.width/2 + focusCat.frame.size.width/2, y: randomY + self.sceneFrame.height/2 + focusCat.frame.size.height/2), duration: moveRate))
    }
}
