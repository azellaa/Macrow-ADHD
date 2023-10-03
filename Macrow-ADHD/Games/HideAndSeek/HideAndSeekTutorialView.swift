//
//  TutorialView.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 03/10/23.
//

import SpriteKit

class TutorialView: SKNode {
    
    private var sceneFrame = CGRect()
    public var popUp = SKSpriteNode()
    private var popUpButton = SKSpriteNode()
    private var background = SKSpriteNode()
    
    private var popUpIdx = 1 // cek udah di tutorial berapa
    
    var delegate: TutorialDelegate?
    
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
        
        popUp = .init(imageNamed: "Popup")
        popUp.name = "popup"
        popUp.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height / 2)
        popUp.setScale(1)
        popUp.zPosition = 25
        addChild(popUp)
        
        popUpButton = .init(imageNamed: "Button")
        popUpButton.name = "button"
        popUpButton.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height * 0.35)
        popUpButton.setScale(1)
        popUpButton.zPosition = 30
        addChild(popUpButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if popUpIdx >= 4 {
                delegate?.tutorialIsOpen(self, isTutorialOpened: false)
                return
            }
            
            if let nodeName = touchedNode.name {
                if nodeName == "button" {
                    switch popUpIdx {
                    case 1:
                        self.popUp.texture = SKTexture(imageNamed: "Popup1")
                        popUpButton.texture = SKTexture(imageNamed: "Button1")
                    case 2:
                        popUp.texture = SKTexture(imageNamed: "Popup2")
                    default:
                        popUp.texture = SKTexture(imageNamed: "Popup3")
                        popUpButton.texture = SKTexture(imageNamed: "Button2")
                    }

                    popUpIdx += 1
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol TutorialDelegate {
    func tutorialIsOpen(_ tutorialView: TutorialView, isTutorialOpened: Bool)
}

