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
    private var blackAlphaBackground = SKSpriteNode()
    private var bg = BackgroundHideAndSeek()
    
    private var popUpIdx = 1 // cek udah di tutorial berapa
    
    var delegate: TutorialDelegate?
    
    private var circleOverlay = SKShapeNode()
    private var tapLabel = SKLabelNode()
    private var tapHandLabel = SKSpriteNode()
    private let cropNode = SKCropNode()
    
    private var rectangleOverlay = SKShapeNode()
    
    private let rabbitCountLabel = SKLabelNode(text: "x0")
    private let rabbitAlpha = SKSpriteNode(imageNamed: "Rabbit_Tap")
    private let foxAlpha = SKSpriteNode(imageNamed: "Fox_Tap")
    private var rabbitCounter = SKSpriteNode()
    
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
        rabbitAlpha.position = CGPoint(x: sceneFrame.width * 0.58 , y: sceneFrame.height * 0.32)
        rabbitAlpha.zPosition = blackAlphaBackground.parent!.zPosition - 15
        rabbitAlpha.setScale(0.826)
        addChild(rabbitAlpha)
        
        rabbitCounter = .init(imageNamed: "RabbitCounter")
        rabbitCounter.position = CGPoint(x: sceneFrame.width * 0.815, y: sceneFrame.height * 0.89)
        rabbitCounter.zPosition = blackAlphaBackground.parent!.zPosition - 2
        addChild(rabbitCounter)
        
        rabbitCountLabel.fontName = "AvenirNext-Bold"
        rabbitCountLabel.fontSize = 30
        rabbitCountLabel.name = "rabbitCountLabel"
        rabbitCountLabel.position = CGPoint(x: sceneFrame.width * 0.835, y: sceneFrame.height * 0.873)
        rabbitCountLabel.zPosition = blackAlphaBackground.parent!.zPosition - 1
        
        addChild(rabbitCountLabel)
        
        cropNode.zPosition = 2 // Ensure it's above other nodes
        circleOverlay = SKShapeNode(ellipseIn: CGRect(origin: CGPoint(x: sceneFrame.width * 0.475 , y: sceneFrame.height * 0.19), size: CGSize(width: 242, height: 242)))
//        circleOverlay.position = CGPoint(x: sceneFrame.width * 0.576 , y: sceneFrame.height * 0.335)
        circleOverlay.fillColor = .white
//        circleOverlay.blendMode = .alpha
        circleOverlay.strokeColor = .clear
        
        bg.getSceneFrame(sceneFrame: sceneFrame)
        bg.addBackground()
        bg.position = CGPoint(x: 0, y: 0)
        
        let rabbit = SKSpriteNode(imageNamed: "Rabbit_Tap")
        rabbit.name = "rabbit"
        rabbit.position = CGPoint(x: sceneFrame.width * 0.58 , y: sceneFrame.height * 0.32)
        rabbit.zPosition = 4
        rabbit.setScale(0.826)
        bg.addChild(rabbit)
        
        
        
        cropNode.maskNode = circleOverlay
        cropNode.addChild(bg)
        
        
        addChild(cropNode)
        
        tapLabel = SKLabelNode(fontNamed: "Jua-Regular")
        tapLabel.text = "Tap !"
        tapLabel.fontSize = 84
        tapLabel.fontColor = .white
        tapLabel.position = CGPoint(x: sceneFrame.width * 0.58, y: sceneFrame.height * 0.548)
        addChild(tapLabel)
        
        tapHandLabel = SKSpriteNode(imageNamed: "tapHandTutorial")
        tapHandLabel.position = CGPoint(x: sceneFrame.width * 0.66, y: sceneFrame.height * 0.258)
        tapHandLabel.zPosition = 7
        addChild(tapHandLabel)
        
        rectangleOverlay = SKShapeNode(rect: CGRect(x: sceneFrame.width * 0.734, y: sceneFrame.height * 0.83, width: 184, height: 104), cornerRadius: 19)
        rectangleOverlay.fillColor = .white
        rectangleOverlay.strokeColor = .clear
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if popUpIdx >= 3 {
                delegate?.tutorialIsOpen(self, isTutorialOpened: false)
                return
            }
            
            switch popUpIdx {
            case 1:
                if circleOverlay.contains(location) {
                    circleOverlay.isHidden = true
                    tapHandLabel.run(SKAction.fadeOut(withDuration: 0.3))
                    tapLabel.isHidden = true
                    
                    cropNode.maskNode = rectangleOverlay
                    
                    let plusOne = SKLabelNode(fontNamed: "Jua-Regular")
                    plusOne.text = "+ 1"
                    plusOne.fontColor = .white
                    plusOne.fontSize = 84
                    
                    plusOne.zPosition = rectangleOverlay.zPosition + 2
                    plusOne.position = CGPoint(x: sceneFrame.width * 0.847, y: sceneFrame.height * 0.736)
//                    addChild(plusOne)
                    
                    rabbitCountLabel.removeFromParent()
                    rabbitCountLabel.zPosition = bg.zPosition + 1
                    bg.addChild(rabbitCountLabel)
                    
                    rabbitCounter.removeFromParent()
                    rabbitCounter.zPosition = bg.zPosition
                    bg.addChild(rabbitCounter)
                    
                    addChild(plusOne)
                    plusOne.alpha = 0
                    
                    plusOne.run( SKAction.sequence([
                        SKAction.fadeIn(withDuration: 1),
                        SKAction.run {
                            
                            self.rabbitCountLabel.text = "x1"
                        },
                        SKAction.wait(forDuration: 1),
                        SKAction.fadeOut(withDuration: 1),
                        SKAction.run { [self] in
                            self.isUserInteractionEnabled = false
                            rectangleOverlay.run(SKAction.fadeOut(withDuration: 0.3))
                            cropNode.maskNode = circleOverlay
                            circleOverlay.isHidden = false
                            
                            rabbitCountLabel.removeFromParent()
                            rabbitCountLabel.zPosition = blackAlphaBackground.zPosition - 1
                            addChild(rabbitCountLabel)
                            
                            rabbitCounter.removeFromParent()
                            rabbitCounter.zPosition = blackAlphaBackground.zPosition - 2
                            addChild(rabbitCounter)
                            
                            tapLabel.text = "Yeay!"
                            tapLabel.isHidden = false
                        },
                        SKAction.wait(forDuration: 1),
                        SKAction.run { [self] in
                            tapLabel.run(SKAction.fadeOut(withDuration: 1))
                            circleOverlay.run(SKAction.fadeOut(withDuration: 0.3))
//                            circleOverlay.removeFromParent()
                            rabbitAlpha.run(SKAction.fadeOut(withDuration: 1))
                            rabbitAlpha.removeFromParent()
                            
                            bg.childNode(withName: "rabbit")?.run(SKAction.fadeOut(withDuration: 1))
                            bg.childNode(withName: "rabbit")?.removeFromParent()
                        },
                        SKAction.wait(forDuration: 1),
                        SKAction.run { [self] in
                            circleOverlay = SKShapeNode(ellipseIn: CGRect(origin: CGPoint(x: sceneFrame.width * 0.315, y: sceneFrame.height * 0.23), size: CGSize(width: 242, height: 242)))
                            circleOverlay.fillColor = .white
                    //        circleOverlay.blendMode = .alpha
                            circleOverlay.strokeColor = .clear
                            cropNode.maskNode = circleOverlay
//                            circleOverlay.position =
                            circleOverlay.run(SKAction.fadeIn(withDuration: 1))
                            tapLabel.position = CGPoint(x: sceneFrame.width * 0.418, y: sceneFrame.height * 0.595)
                            tapLabel.text = "Tap !"
                            tapLabel.run(SKAction.fadeIn(withDuration: 1))
                            
                            tapHandLabel.position = CGPoint(x: sceneFrame.width * 0.5, y: sceneFrame.height * 0.287)
                            tapHandLabel.run(SKAction.fadeIn(withDuration: 0.3))
                            
                            let fox = SKSpriteNode(imageNamed: "Fox_Tap")
                            fox.name = "fox"
                            fox.position = CGPoint(x: sceneFrame.width * 0.419 , y: sceneFrame.height * 0.328)
                            fox.zPosition = 3
                            fox.setScale(0.7)
                            bg.addChild(fox)
                            self.isUserInteractionEnabled = true
                            popUpIdx += 1
                            plusOne.removeFromParent()
                        }
                    ]))
                    
                }
            case 2:
                let redAlphaBackground = SKSpriteNode()
                redAlphaBackground.size = CGSize(width: sceneFrame.width, height: sceneFrame.height)
                redAlphaBackground.color = .redTutorial
                redAlphaBackground.alpha = 0.5
                redAlphaBackground.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height / 2)
                redAlphaBackground.zPosition = blackAlphaBackground.zPosition + 100
                
                bg.addChild(redAlphaBackground)
                tapLabel.text = "Oh No!"
                tapLabel.fontColor = .redTutorial
                tapHandLabel.run(SKAction.fadeOut(withDuration: 0.3))
                
                foxAlpha.position = CGPoint(x: sceneFrame.width * 0.419 , y: sceneFrame.height * 0.328)
                foxAlpha.zPosition = blackAlphaBackground.parent!.zPosition - 36
                foxAlpha.setScale(0.7)
                addChild(foxAlpha)
                
                self.run(SKAction.sequence([
                    SKAction.wait(forDuration: 2),
                    SKAction.run { [self] in
                        circleOverlay.run(SKAction.fadeOut(withDuration: 0.3))
                        tapLabel.run(SKAction.fadeOut(withDuration: 0.3))
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run { [self] in
                        redAlphaBackground.removeFromParent()
                        cropNode.maskNode = rectangleOverlay
                        rectangleOverlay.run(SKAction.fadeIn(withDuration: 1))
                        
                        rabbitCountLabel.removeFromParent()
                        rabbitCountLabel.zPosition = bg.zPosition + 1
                        bg.addChild(rabbitCountLabel)
                        
                        rabbitCounter.removeFromParent()
                        rabbitCounter.zPosition = bg.zPosition
                        bg.addChild(rabbitCounter)
                        
                        let plusOne = SKLabelNode(fontNamed: "Jua-Regular")
                        plusOne.text = "- 1"
                        plusOne.fontColor = .redTutorial
                        plusOne.fontSize = 84
                        
                        plusOne.zPosition = rectangleOverlay.zPosition + 2
                        plusOne.position = CGPoint(x: sceneFrame.width * 0.847, y: sceneFrame.height * 0.736)
                        plusOne.alpha = 0
                        addChild(plusOne)
                        plusOne.run(SKAction.sequence([
                            SKAction.fadeIn(withDuration: 1),
                            SKAction.run {
                                self.rabbitCountLabel.text = "x0"
                            },
                            SKAction.wait(forDuration: 1),
                            SKAction.fadeOut(withDuration: 1),
                            SKAction.run { [self] in
                                rectangleOverlay.run(SKAction.fadeOut(withDuration: 1))
                                
                                rabbitCountLabel.removeFromParent()
                                rabbitCountLabel.zPosition = blackAlphaBackground.zPosition - 1
                                addChild(rabbitCountLabel)
                                
                                rabbitCounter.removeFromParent()
                                rabbitCounter.zPosition = blackAlphaBackground.zPosition - 2
                                addChild(rabbitCounter)
                                
                                foxAlpha.removeFromParent()
                                let letStart = SKLabelNode(fontNamed: "Jua-Regular")
                                letStart.text = "Lets Start!"
                                letStart.position = CGPoint(x: sceneFrame.width/2, y: sceneFrame.height/2)
                                letStart.fontColor = .white
                                letStart.fontSize = 96
                                letStart.alpha = 0
                                addChild(letStart)
                                letStart.run(SKAction.fadeIn(withDuration: 2))
                            },
                            SKAction.run {
                                self.popUpIdx += 1
                            }
                        ]))
                    }
                ]))
            default:
                print("Def")
            }
            
           
            
//            if let nodeName = touchedNode.name {
//                if nodeName == "button" {
//                    switch popUpIdx {
//                    case 1:
//                        self.popUp.texture = SKTexture(imageNamed: "Popup1")
//                        popUpButton.texture = SKTexture(imageNamed: "Button1")
//                    case 2:
//                        popUp.texture = SKTexture(imageNamed: "Popup2")
//                    default:
//                        popUp.texture = SKTexture(imageNamed: "Popup3")
//                        popUpButton.texture = SKTexture(imageNamed: "Button2")
//                    }
//
//                    popUpIdx += 1
//                }
//            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol TutorialDelegate {
    func tutorialIsOpen(_ tutorialView: TutorialView, isTutorialOpened: Bool)
}

