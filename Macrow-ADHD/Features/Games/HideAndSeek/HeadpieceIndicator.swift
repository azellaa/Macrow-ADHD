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
        
        headpieceStatus = SKSpriteNode(imageNamed: ResourcePath.notConnected)
        headpieceStatus.zPosition = 10
        addChild(headpieceStatus)
        
        
        
        
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
                    self?.headpieceStatus.texture = self?.updateIcon(ResourcePath.connecting1)
//                    self?.showPopupConnecting()
                case 2:
                    self?.headpieceStatus.texture = self?.updateIcon(ResourcePath.connecting2)
//                    self?.showPopupConnecting()
                case 3:
                    self?.headpieceStatus.texture = self?.updateIcon(ResourcePath.connecting3)
//                    self?.showPopupConnecting()
                case 4:
                    self?.headpieceStatus.texture = self?.updateIcon(ResourcePath.connected)
//                    self?.hidePopupAnimation()
                default:
                    self?.headpieceStatus.texture = self?.updateIcon(ResourcePath.notConnected)
//                    self?.showPopupDisconnect()
                }
            }
            .store(in: &cancellables)
    }
    
    func updateIcon(_ imageName: String) -> SKTexture{
        return SKTexture(imageNamed: imageName)
    }
    
}
