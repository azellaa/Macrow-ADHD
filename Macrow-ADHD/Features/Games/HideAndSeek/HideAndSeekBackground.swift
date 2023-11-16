//
//  HideAndSeekBackground.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 03/10/23.
//

import SpriteKit

class BackgroundHideAndSeek: SKNode {
    private var land1 = PassThroughBackgroundNode()
    private var land2 = PassThroughBackgroundNode()
    private var land3 = PassThroughBackgroundNode()
    private var land4 = PassThroughBackgroundNode()
    private var background = PassThroughBackgroundNode()
    private var bushLeft = PassThroughBackgroundNode()
    private var bushRight = PassThroughBackgroundNode()
    private var bushBack = PassThroughBackgroundNode()
    private var rocks = PassThroughBackgroundNode()
    private var wood = PassThroughBackgroundNode()
    
    private var sceneFrame = CGRect()
    
    override init() {
        super.init()
    }
    
    func getSceneFrame(sceneFrame: CGRect) {
        self.sceneFrame = sceneFrame
    }
    
    func addBackground() {
        land1 = .init(imageNamed: "Land 1")
        land1.anchorPoint = CGPoint(x: 0, y: 0)
        land1.position = CGPoint(x: 0, y: 0)
        land1.setScale(1)
        land1.zPosition = 5
        
        land2 = .init(imageNamed: "Land 2")
        land2.position = CGPoint(x: sceneFrame.width / 2, y: land2.frame.height / 2)
        land2.setScale(1)
        land2.zPosition = 4
        
        land3 = .init(imageNamed: "Land 3")
        land3.position = CGPoint(x: sceneFrame.width / 2, y: land3.frame.height / 2)
        land3.setScale(1)
        land3.zPosition = 2
        
        land4 = .init(imageNamed: "Land 4")
        land4.position = CGPoint(x: sceneFrame.width - (land4.frame.width / 2), y: land4.frame.height / 2)
        land4.setScale(1)
        land4.zPosition = 1
        
        background = .init(imageNamed: "Background")
        background.position = CGPoint(x: sceneFrame.width / 2, y: sceneFrame.height / 2)
        background.setScale(1)
        background.zPosition = 0
        
        bushLeft = .init(imageNamed: "Bush Left")
        bushLeft.position = CGPoint(x: bushLeft.frame.width / 2, y: bushLeft.frame.height / 2)
        bushLeft.setScale(1)
        bushLeft.zPosition = 7
        
        bushRight = .init(imageNamed: "Bush Right")
        bushRight.position = CGPoint(x: sceneFrame.width - (bushRight.frame.width / 2), y: bushRight.frame.height / 2)
        bushRight.setScale(1)
        bushRight.zPosition = 6
        
        bushBack = .init(imageNamed: "Bush Back")
        bushBack.position = CGPoint(x: sceneFrame.width * 0.418, y: sceneFrame.height * 0.245)
        bushBack.setScale(1)
        bushBack.zPosition = 4
        
        wood = .init(imageNamed: "Wood Log")
        wood.position = CGPoint(x: sceneFrame.width * 0.66, y: sceneFrame.height * 0.16)
        wood.setScale(1)
        wood.zPosition = 5
        
        rocks = .init(imageNamed: "Rocks")
        rocks.position = CGPoint(x: sceneFrame.width * 0.272 , y: sceneFrame.height * 0.171)
        rocks.setScale(1)
        rocks.zPosition = 6
        
        addChild(land1)
        addChild(land2)
        addChild(land3)
        addChild(land4)
        addChild(background)
        addChild(bushLeft)
        addChild(bushRight)
        addChild(bushBack)
        addChild(wood)
        addChild(rocks)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
