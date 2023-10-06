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
        
        // dim the entire background of the scene to 70% darker
//        SKSpriteNode* background = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:0
//                                                                                     green:0
//                                                                                      blue:0
//                                                                                     alpha:0.7]
//                                                                size:self.frame.size];
//
//        // make a square of 100,100. This could be an image or shapenode rendered to a spritenode
//        // make the cut out only dim 20% - this is because no dim will look very harsh
//        SKSpriteNode* cutOut = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:0
//                                                                                 green:0
//                                                                                  blue:0
//                                                                                 alpha:0.2]
//                                                            size:CGSizeMake(100,100)];
//
//        // add the cut out to the background and make the blend mode replace the colors
//        cutOut.blendMode = SKBlendModeReplace;
//        [background addChild:cutOut];
//
//        // we now need to make a texture from this node, otherwise the cutout will replace the underlying
//        // background completely
//
//        SKTexture* newTexture = [self.view textureFromNode:background];
//        SKSpriteNode* newBackground = [SKSpriteNode spriteNodeWithTexture:newTexture];
//
//        // position our background over the entire scene by adjusting the anchor point (or position)
//        newBackground.anchorPoint = CGPointMake(0,0);
//        [self addChild:newBackground];
//
//        // if you have other items in the scene, you'll want to increaes the Z position to make it go ontop.
//        newBackground.zPosition = 5;
        
        var circleOverlay = SKShapeNode(circleOfRadius: 20)
        circleOverlay.alpha = 0.2
        circleOverlay.fillColor = .white
        circleOverlay.strokeColor = .clear
        circleOverlay.blendMode = .subtract
        background.addChild(circleOverlay)
        
        var newBackground = BackgroundHideAndSeek()
        
//        newBackground.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(newBackground)
        newBackground.zPosition = 5
        
//        popUpText.position = CGPoint(x: sceneFrame.width / 2 , y: sceneFrame.height / 2)
//        popUpText.zPosition = 25
//        addChild(popUpText)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
