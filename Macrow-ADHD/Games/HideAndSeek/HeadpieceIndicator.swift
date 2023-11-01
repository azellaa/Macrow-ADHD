//
//  HeadpieceIndicator.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 10/4/23.
//

import Foundation
import SpriteKit
import Combine

class HeadpieceIndicator: SKNode {
    private var headpieceStatus = SKSpriteNode()
    private var pausedPopup = SKSpriteNode()
    private var pausedLabel = SKLabelNode()
    
    private var sceneFrame = CGRect()
    
    private var cancellables: Set<AnyCancellable> = []
    var mwmObject = MWMInstance.shared
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSceneFrame(sceneFrame: CGRect) {
        self.sceneFrame = sceneFrame
    }
    
    func buildIndicator() {
        
        headpieceStatus = SKSpriteNode(imageNamed: "noSignalIcon")
        headpieceStatus.zPosition = 10
        addChild(headpieceStatus)
        
        pausedPopup = SKSpriteNode(imageNamed: "noSignalBg")
        pausedPopup.setScale(2)
        pausedPopup.zPosition = 25
        pausedPopup.position.x = sceneFrame.width * 1.5
        pausedPopup.position.y = pausedPopup.size.height - sceneFrame.height * 0.17
        
        addChild(pausedPopup)
        
        pausedLabel = SKLabelNode(fontNamed: "Jua-Regular")
        pausedLabel.text = "Oops! Head piece disconected...\nTell the adults to help you"
        pausedLabel.horizontalAlignmentMode = .center
        pausedLabel.verticalAlignmentMode = .center
        pausedLabel.numberOfLines = 2
        pausedLabel.fontColor = .black
        pausedLabel.fontSize = 21
        pausedLabel.zPosition = 25
        pausedLabel.preferredMaxLayoutWidth = pausedPopup.frame.width
        
        
        pausedPopup.addChild(pausedLabel)
        
        
//        // TESTING
//        pausedPopup.run(SKAction.sequence([
//            SKAction.moveTo(y: sceneFrame.height * 0.91, duration: 0.5),
//            SKAction.wait(forDuration: TimeInterval(3)),
//            SKAction.moveTo(y: sceneFrame.height + pausedPopup.size.height / 2, duration: 0.5)
//        ]))
        
        mwmObject.signalStatusPublisher
            .sink { [weak self] signalStatus in
                // Handle the emitted MWMData here
                switch signalStatus {
                case 1:
                    self?.headpieceStatus.texture = self?.updateIcon("poorSignalIcon")
                    self?.showPopupConnecting()
                case 2:
                    self?.headpieceStatus.texture = self?.updateIcon("weakSignalIcon")
                    self?.showPopupConnecting()
                case 3:
                    self?.headpieceStatus.texture = self?.updateIcon("connectingIcon")
                    self?.showPopupConnecting()
                case 4:
                    self?.headpieceStatus.texture = self?.updateIcon("connectedIcon")
                    self?.hidePopupAnimation()
                default:
                    self?.headpieceStatus.texture = self?.updateIcon("noSignalIcon")
                    self?.showPopupDisconnect()
                }
            }
            .store(in: &cancellables)
    }
    
    func updateIcon(_ imageName: String) -> SKTexture{
        return SKTexture(imageNamed: imageName)
    }
    
    func showPopupConnecting() {
        pausedPopup.texture = updateIcon("defaultBg")
        pausedLabel.text = "Make sure you wear the headpiece correctly"
        showPopupAnimation()
    }
    
    func showPopupDisconnect() {
        pausedPopup.texture = updateIcon("noSignalBg")
        pausedLabel.text = "Oops! Head piece disconected...\nTell the adults to help you"
        showPopupAnimation()
    }
    
    func showPopupAnimation() {
        let moveAction = SKAction.moveTo(y: sceneFrame.height * 0.91, duration: 0.5)
        pausedPopup.run(moveAction)
    }
    
    func hidePopupAnimation() {
        let moveAction = SKAction.moveTo(y: sceneFrame.height + pausedPopup.size.height / 2, duration: 0.5)
        pausedPopup.run(moveAction)
    }
}
