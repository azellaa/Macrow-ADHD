//
//  ProgressBar.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 03/10/23.
//

import SpriteKit

class ProgressBar: SKNode {
    
    private var maxProgress = CGFloat(100)
    private var maxProgressBarWidth = CGFloat(0)
    
    private var progressBar = SKSpriteNode()
    private var progressBarContainer = SKSpriteNode()
    
    private let progressTexture = SKTexture(imageNamed: "4Bar")
    private let progressContainerTexture = SKTexture(imageNamed: "EmptyBar")
    
    private var sceneFrame = CGRect()
    
    override init() {
        super.init()
    }
    
    func getSceneFrame(sceneFrame: CGRect) {
        self.sceneFrame = sceneFrame
        maxProgressBarWidth = sceneFrame.width * 0.575
    }
    
    func buildProgressBar() {
        progressBarContainer = SKSpriteNode(texture: progressContainerTexture, size: progressContainerTexture.size())
        progressBarContainer.zPosition = 10
        
        progressBar = SKSpriteNode(texture: progressTexture, size: progressTexture.size())
        progressBar.size.width = CGFloat(maxProgressBarWidth)
        progressBar.size.height = CGFloat(progressBarContainer.size.height * 0.45)
        progressBar.position.x = -maxProgressBarWidth / 2.36
        progressBar.position.y = progressBarContainer.position.y + 1
        progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        let cropNode = SKCropNode()
        let childNode = SKSpriteNode(texture: progressTexture, size: progressTexture.size())
        cropNode.maskNode = progressBar
        cropNode.zPosition = 15
        cropNode.position.x = 34
        
        cropNode.addChild(childNode)
        addChild(cropNode)
        addChild(progressBarContainer)
    }
    
    func updateProgressBar(_ progress: CGFloat) {
        print(progress)
        progressBar.run(SKAction.resize(toWidth: CGFloat(progress / maxProgress) * maxProgressBarWidth, duration: 0.2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
