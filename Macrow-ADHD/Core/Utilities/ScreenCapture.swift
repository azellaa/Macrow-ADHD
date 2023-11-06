//
//  ScreenCapture.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/2/23.
//

import Foundation
import SpriteKit

class ScreenCapture {
    init () {}
    static func captureScreenAsSpriteNode(scene: SKScene) -> SKSpriteNode? {
        // 1. Capture the current screen as a UIImage
        guard let view = scene.view else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let capturedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        
        // 2. Create an SKTexture from the UIImage
        let texture = SKTexture(image: capturedImage)
        
        // 3. Create an SKSpriteNode with the SKTexture
        let spriteNode = SKSpriteNode(texture: texture)
        
        // Optionally, you can set the position, scale, and other properties of the spriteNode here
        spriteNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        
        return spriteNode
    }
}
