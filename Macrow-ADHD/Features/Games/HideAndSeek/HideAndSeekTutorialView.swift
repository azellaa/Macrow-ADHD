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
    private var circleOverlayMedium = SKShapeNode()
    private var circleOverlaySmall = SKShapeNode()
    private var tapLabel = SKLabelNode()
    private var tapHandLabel = SKSpriteNode()
    private let cropNode = SKCropNode()
    
    //    private var rectangleOverlay = SKShapeNode()
    
    //    private let rabbitCountLabel = SKLabelNode(text: "x0")
    private let rabbitAlpha = SKSpriteNode(imageNamed: "Rabbit_Hide")
    private let foxAlpha = SKSpriteNode(imageNamed: "Fox_Seek")
    private let plusOneStar = SKSpriteNode(imageNamed: "plusOneStar")
    private let minusOneStar = SKSpriteNode(imageNamed: "minusOneStar")
    
    private var isAnimationRunning = false
    
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
        rabbitAlpha.setScale(0.6)
        addChild(rabbitAlpha)
        
        
        //        plusOneStar.zPosition = blackAlphaBackground.parent!.zPosition - 1
        plusOneStar.position = CGPoint(x: sceneFrame.width * 0.52 + plusOneStar.frame.width/2, y: sceneFrame.height * 0.5 + plusOneStar.frame.height)
        plusOneStar.alpha = 0
        
        addChild(plusOneStar)
        
        minusOneStar.position = CGPoint(x: sceneFrame.width * 0.37 + minusOneStar.frame.width/2, y: sceneFrame.height * 0.546 + minusOneStar.frame.height)
        minusOneStar.alpha = 0
        
        addChild(minusOneStar)
        
        
        
        cropNode.zPosition = 2 // Ensure it's above other nodes
        circleOverlay = SKShapeNode(ellipseIn: CGRect(origin: CGPoint(x: sceneFrame.width * 0.475 , y: sceneFrame.height * 0.19), size: CGSize(width: 242, height: 242)))
        //        circleOverlay.position = CGPoint(x: sceneFrame.width * 0.576 , y: sceneFrame.height * 0.335)
        circleOverlay.fillColor = .white
        //        circleOverlay.blendMode = .alpha
        circleOverlay.strokeColor = .clear
        
        circleOverlayMedium = SKShapeNode(ellipseIn: CGRect(origin: CGPoint(x: 0 , y: 0), size: CGSize(width: 181, height: 181)))
        circleOverlayMedium.position = CGPoint(x: sceneFrame.width * 0.5 , y: sceneFrame.height * 0.225)
        circleOverlayMedium.fillColor = .white
        circleOverlayMedium.strokeColor = .clear
        circleOverlayMedium.zPosition = 5
        circleOverlayMedium.alpha = 0.15
        
        circleOverlaySmall = SKShapeNode(ellipseIn: CGRect(origin: CGPoint(x: 0 , y: 0), size: CGSize(width: 133, height: 133)))
        circleOverlaySmall.position = CGPoint(x: sceneFrame.width * 0.5195 , y: sceneFrame.height * 0.253)
        circleOverlaySmall.fillColor = .white
        circleOverlaySmall.strokeColor = .clear
        circleOverlaySmall.zPosition = 6
        circleOverlaySmall.alpha = 0.15
        
        bg.getSceneFrame(sceneFrame: sceneFrame)
        bg.addBackground()
        bg.position = CGPoint(x: 0, y: 0)
        
        let rabbit = SKSpriteNode(imageNamed: "Rabbit_Hide")
        rabbit.name = "rabbit"
        rabbit.position = CGPoint(x: sceneFrame.width * 0.58 , y: sceneFrame.height * 0.32)
        rabbit.zPosition = 4
        rabbit.setScale(0.6)
        bg.addChild(rabbit)
        
        cropNode.maskNode = circleOverlay
        cropNode.addChild(bg)
        
        addChild(cropNode)
        addChild(circleOverlayMedium)
        addChild(circleOverlaySmall)
        
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
                if circleOverlay.contains(location) && !isAnimationRunning {
                    isAnimationRunning = true
                    //                    circleOverlay.isHidden = true
                    tapHandLabel.run(SKAction.fadeOut(withDuration: 0.3)) {
                        self.tapLabel.alpha = 0
                        self.plusOneStar.run(SKAction.fadeIn(withDuration: 1)) {
                            self.plusOneStar.run(SKAction.wait(forDuration: 1)){
                                self.plusOneStar.run(SKAction.fadeOut(withDuration: 1)) {
                                    self.tapLabel.text = "Yeay!"
                                    self.circleOverlayMedium.alpha = 0
                                    self.circleOverlaySmall.alpha = 0
                                    self.rabbitAlpha.texture = SKTexture(imageNamed: "Rabbit_Tap")
                                    if let rabbit = self.bg.childNode(withName: "rabbit") as? SKSpriteNode {
                                        rabbit.texture = SKTexture(imageNamed: "Rabbit_Tap")
                                    }
                                    self.tapLabel.run(SKAction.fadeIn(withDuration: 1)){ [self] in
                                        bg.childNode(withName: "rabbit")?.removeFromParent()
                                        rabbitAlpha.removeFromParent()
                                        
                                        circleOverlay = SKShapeNode(ellipseIn: CGRect(origin: CGPoint(x: sceneFrame.width * 0.315, y: sceneFrame.height * 0.23), size: CGSize(width: 242, height: 242)))
                                        circleOverlay.fillColor = .white
                                //        circleOverlay.blendMode = .alpha
                                        circleOverlay.strokeColor = .clear
                                        cropNode.maskNode = circleOverlay
                    //                            circleOverlay.position =
                                        
                                        circleOverlayMedium.alpha = 0.15
                                        circleOverlayMedium.position = CGPoint(x: sceneFrame.width * 0.34, y: sceneFrame.height * 0.265)
                                        
                                        circleOverlaySmall.alpha = 0.15
                                        circleOverlaySmall.position = CGPoint(x: sceneFrame.width * 0.3595 , y: sceneFrame.height * 0.293)
                                        
                                        circleOverlay.run(SKAction.fadeIn(withDuration: 1))
                                        tapLabel.text = "Tap!"
                                        tapLabel.position = CGPoint(x: sceneFrame.width * 0.418, y: sceneFrame.height * 0.595)
                                        popUpIdx += 1
                                        
                                        let fox = SKSpriteNode(imageNamed: "Fox_Seek")
                                        fox.name = "fox"
                                        fox.position = CGPoint(x: sceneFrame.width * 0.419 , y: sceneFrame.height * 0.328)
                                        fox.zPosition = 3
                                        fox.setScale(0.5)
                                        bg.addChild(fox)
                                        
                                        foxAlpha.position = CGPoint(x: sceneFrame.width * 0.419 , y: sceneFrame.height * 0.328)
                                        foxAlpha.zPosition = blackAlphaBackground.parent!.zPosition - 36
                                        foxAlpha.setScale(0.5)
                                        addChild(foxAlpha)
                                        
                                        tapHandLabel.position = CGPoint(x: sceneFrame.width * 0.5, y: sceneFrame.height * 0.287)
                                        tapHandLabel.run(SKAction.fadeIn(withDuration: 0.3))
                                        isAnimationRunning = false
                                    }
                                }
                            }
                            
                        }
                    }
                    
//                    self.circleOverlay.alpha = 0
                    
                    //                    tapLabel.isHidden = true
                    
                }
            case 2:
                if circleOverlay.contains(location) && !isAnimationRunning {
                    isAnimationRunning = true
                    self.foxAlpha.texture = SKTexture(imageNamed: "Fox_Tap")
                    if let fox = self.bg.childNode(withName: "fox") as? SKSpriteNode {
                        fox.texture = SKTexture(imageNamed: "Fox_Tap")
                    }
                    circleOverlaySmall.removeFromParent()
                    circleOverlayMedium.removeFromParent()
                    let redAlphaBackground = SKSpriteNode()
                    redAlphaBackground.size = CGSize(width: sceneFrame.width, height: sceneFrame.height)
                    redAlphaBackground.color = .redTutorial
                    redAlphaBackground.alpha = 0.5
                    redAlphaBackground.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height / 2)
                    redAlphaBackground.zPosition = blackAlphaBackground.zPosition + 100
                    
                    bg.addChild(redAlphaBackground)
                    tapLabel.alpha = 0
                    tapLabel.text = "Oh No!"
                    tapLabel.fontColor = .redTutorial
                    tapHandLabel.run(SKAction.fadeOut(withDuration: 0.3))
                    minusOneStar.run(SKAction.sequence([
                        SKAction.fadeIn(withDuration: 1),
                        SKAction.wait(forDuration: 1),
                        SKAction.fadeOut(withDuration: 0.3)
                    ])) { [self] in
                        tapLabel.run(SKAction.sequence([
                            SKAction.fadeIn(withDuration: 1),
                            SKAction.wait(forDuration: 1)
                        ])) { [self] in
                            foxAlpha.removeFromParent()
                            tapLabel.removeFromParent()
                            cropNode.removeFromParent()
                            circleOverlay.removeFromParent()
                            bg.childNode(withName: "fox")?.removeFromParent()
                            let letStart = SKLabelNode(fontNamed: "Jua-Regular")
                            letStart.text = "Lets Start!"
                            letStart.position = CGPoint(x: sceneFrame.width/2, y: sceneFrame.height/2)
                            letStart.fontColor = .white
                            letStart.fontSize = 96
                            letStart.alpha = 0
                            addChild(letStart)
                            letStart.run(SKAction.sequence([
                                SKAction.fadeIn(withDuration: 2),
                                SKAction.wait(forDuration: 1)
                            ])){
                                self.delegate?.tutorialIsOpen(self, isTutorialOpened: false)
                            }
                        }
                    }
                }
                
                
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

