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
        
        headpieceStatus = SKSpriteNode(imageNamed: "nosignal")
        headpieceStatus.zPosition = 10
        headpieceStatus.position.x = sceneFrame.width * 0.9
        headpieceStatus.position.y = sceneFrame.height * 0.87
        addChild(headpieceStatus)
        
        mwmObject.signalStatusPublisher
            .sink { [weak self] signalStatus in
                // Handle the emitted MWMData here
                switch signalStatus {
                case 1:
                    self?.headpieceStatus.texture = self?.updateIcon("connecting1")
                case 2:
                    self?.headpieceStatus.texture = self?.updateIcon("connecting2")
                case 3:
                    self?.headpieceStatus.texture = self?.updateIcon("connecting3")
                case 4:
                    self?.headpieceStatus.texture = self?.updateIcon("connected")
                default:
                    self?.headpieceStatus.texture = self?.updateIcon("nosignal")
                }
            }
            .store(in: &cancellables)
    }
    
    func updateIcon(_ imageName: String) -> SKTexture{
        return SKTexture(imageNamed: imageName)
    }
}
