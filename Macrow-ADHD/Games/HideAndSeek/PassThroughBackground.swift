//
//  PassThroughBackground.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 03/10/23.
//

import Foundation
import SpriteKit
class PassThroughBackgroundNode: SKSpriteNode {
    override func contains(_ p: CGPoint) -> Bool {
        // Always return false to make this node non-blocking for touches
        return false
    }
    
    
}
