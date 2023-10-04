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
    private var background = SKSpriteNode()
    
    
    override init() {
        super.init()
    }
    
    required init(sceneFrame: CGRect) {
        super.init()
        self.sceneFrame = sceneFrame
        
        background.size = CGSize(width: sceneFrame.width, height: sceneFrame.height)
        background.color = .black
        background.alpha = 0.5
        background.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height / 2)
        addChild(background)
        
        
        popUpText.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height / 2)
        popUpText.zPosition = 25
        addChild(popUpText)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
