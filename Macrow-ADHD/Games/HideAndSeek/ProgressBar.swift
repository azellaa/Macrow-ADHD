//
//  ProgressBar.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 03/10/23.
//

import SpriteKit

extension SKColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

class ProgressBar: SKNode {

    private var maxProgress = CGFloat(100)
    private var progressBarRadius = CGFloat(0)
    
    private var progressBarBackground = SKSpriteNode()
    private var progressBar = SKSpriteNode()
    private var progressCircle = SKShapeNode()
    
    private var sceneFrame = CGRect()

    override init() {
        super.init()
    }

    func getSceneFrame(sceneFrame: CGRect) {
        self.sceneFrame = sceneFrame
        progressBarRadius = SKTexture(imageNamed: "4Bar new").size().width/2
    }

    func buildProgressBar() {
        // Create the circular background for the progress bar
        let progressBarBackgroundTexture = SKTexture(imageNamed: "emptyBar new") // Replace with your background image name
        progressBarBackground = SKSpriteNode(texture: progressBarBackgroundTexture)
        progressBarBackground.size = CGSize(width: progressBarBackground.size.width
                                            , height: progressBarBackground.size.height)
        progressBarBackground.position = CGPoint(x: sceneFrame.width * -0.45,  y: frame.height * -0.85)
        progressBarBackground.zPosition = 10
        addChild(progressBarBackground)
        
        // Create the circular progress indicator
//        let progressTexture = SKTexture(imageNamed: "4Bar new") // Replace with your progress indicator image name
//        progressBar = SKSpriteNode(texture: progressTexture)
//        progressBar.size = CGSize(width: progressBarRadius*2, height: progressBarRadius*2)
//        progressBar.position = CGPoint(x: sceneFrame.width * -0.45, y: frame.height * -0.89)
//        progressBar.zPosition = 15
//        addChild(progressBar)
        
        // Create the dynamic progress circle
        let progressCirclePath = UIBezierPath(arcCenter: .zero, radius: progressBarRadius/2, startAngle: -CGFloat.pi / 2, endAngle: -CGFloat.pi / 1, clockwise: true)
        // kalo mau rubah progress edit yg di endAngle ini ajaa
        progressCircle = SKShapeNode(path: progressCirclePath.cgPath)
        progressCircle.position = CGPoint(x: sceneFrame.width * -0.45, y: frame.height * -0.89)
        progressCircle.strokeColor = SKColor(hex: 0x986922) // Change the color to your preference
        progressCircle.lineWidth = progressBarRadius/1.3 // Adjust the width as needed
        progressCircle.zPosition = 15
        addChild(progressCircle)
        
        let bee = SKSpriteNode(imageNamed: "Bee")
        bee.position = CGPoint(x: sceneFrame.width * -0.45, y: frame.height * -0.89)
        bee.zPosition = 15
        addChild(bee)
    }

    func updateProgressBar(_ progress: CGFloat) {
        // Calculate the end angle of the progress circle based on the progress
        let endAngle = -CGFloat.pi / 2 + 2 * CGFloat.pi * (progress / maxProgress)
        
        // Create the new path for the progress circle
        let progressCirclePath = UIBezierPath(arcCenter: .zero, radius: progressBarRadius/2, startAngle: -CGFloat.pi / 2, endAngle: endAngle, clockwise: false)
        progressCircle.path = progressCirclePath.cgPath
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

