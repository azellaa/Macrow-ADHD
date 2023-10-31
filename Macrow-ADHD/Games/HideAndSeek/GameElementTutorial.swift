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
    private var bubbleBox = SKSpriteNode()
    private var bubbleText = SKLabelNode()
    
    private var attentionPopup = AttentionPopup()
    
    private let cropNode = SKCropNode()
    private var rectangleOverlay = SKShapeNode()
    
    private var text: String
    
    private var scoreBox = ProgressBar()
    
    init(size: CGSize, text: String) {
        self.text = text
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
        
        bubbleBox = .init(imageNamed: "bubbleBox")
        bubbleBox.size.width = frame.width * 0.28
        bubbleBox.size.height = frame.height * 0.15
        bubbleBox.position = CGPoint(x: frame.width * 0.49, y: frame.height * 0.64)
        bubbleBox.zPosition = 22
        addChild(bubbleBox)
        
        bubbleText.fontName = "Jua-Regular"
        bubbleText.fontSize = 24
        bubbleText.fontColor = .black
        bubbleText.text = "This bar shows your focus level"
        bubbleText.numberOfLines = 2
        bubbleText.lineBreakMode = NSLineBreakMode.byWordWrapping
        bubbleText.preferredMaxLayoutWidth = frame.width * 0.25
        bubbleText.position = CGPoint(x: frame.width * 0.491, y: frame.height * 0.613)
        bubbleText.zPosition = 23
        addChild(bubbleText)
    }
    
    func nextTutorial(text: String) {
        bubbleText.text = text
    }
    
    func hideAll() {
        bubbleBox.isHidden = true
        bubbleText.isHidden = true
        will.isHidden = true
        cropNode.isHidden = true
        rectangleOverlay.isHidden = true
        blackAlphaBackground.isHidden = true
        scoreBox.zPosition = 1
    }
    
    func removePause() {
        bubbleBox.isHidden = false
        bubbleText.isHidden = false
        will.isHidden = false
        cropNode.isHidden = false
        rectangleOverlay.isHidden = false
        blackAlphaBackground.isHidden = false
        scoreBox.zPosition = 22
        
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
