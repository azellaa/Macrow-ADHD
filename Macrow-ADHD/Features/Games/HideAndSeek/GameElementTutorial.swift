//
//  GameElementTutorial.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 30/10/23.
//

import SpriteKit
import SwiftUI

class GameElementTutorial: SKScene, SKPhysicsContactDelegate {
    private var popUpButton = SKSpriteNode()
    private var blackAlphaBackground = SKSpriteNode()
    private var bg = BackgroundHideAndSeek()
    private var background = BackgroundHideAndSeek()
    private var will = SKSpriteNode()
    
    private var attentionPopup = AttentionPopup()
    private var scoreBox = ProgressBar()
    
    private let cropNode = SKCropNode()
    private var rectangleOverlay = SKShapeNode()
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        blackAlphaBackground.size = CGSize(width: frame.width, height: frame.height)
        blackAlphaBackground.color = .black
        blackAlphaBackground.alpha = 0.7
        blackAlphaBackground.position = CGPoint(x: frame.width / 2 , y: frame.height / 2)
        blackAlphaBackground.zPosition = 20
        addChild(blackAlphaBackground)
        
        background.getSceneFrame(sceneFrame: frame)
        background.addBackground()
        background.zPosition = 0
        addChild(background)
        
        bg.getSceneFrame(sceneFrame: frame)
        bg.addBackground()
        bg.position = CGPoint(x: 0, y: 0)
        
        scoreBox.getSceneFrame(sceneFrame: frame)
        scoreBox.setScale(0.9)
        scoreBox.tutorialScoreBox()
        scoreBox.zPosition = 22
        scoreBox.position = CGPoint(x: frame.width * 0.47 , y: frame.height * 0.93)
        addChild(scoreBox)
        
        rectangleOverlay = SKShapeNode(rect: CGRect(x: frame.width * 0.014, y: frame.height * 0.876, width: 230, height: 90), cornerRadius: 19)
        rectangleOverlay.fillColor = .white
        
        let cropNode = SKCropNode()
        cropNode.maskNode = rectangleOverlay
        cropNode.zPosition = 21
        
        cropNode.addChild(bg)
        addChild(cropNode)
        
        will = .init(imageNamed: "will")
        will.setScale(1)
        will.position = CGPoint(x: frame.width * 0.27, y: frame.height * 0.345)
        will.zPosition = 22
        addChild(will)
    }
    
    func hideAll() {
        will.isHidden = true
        cropNode.isHidden = true
        rectangleOverlay.isHidden = true
        blackAlphaBackground.isHidden = true
        scoreBox.zPosition = 1
    }
    
    func removePause() {
        will.isHidden = false
        blackAlphaBackground.isHidden = false
        
        attentionPopup.removeAllActions()
        attentionPopup.removeFromParent()
    }
    
    func pauseTutorial() {
        attentionPopup = AttentionPopup(sceneFrame: frame)
        attentionPopup.zPosition = 25
        addChild(attentionPopup)
        
        attentionPopup.startShowPause(self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        attentionPopup.update(currentTime)
    }
}
