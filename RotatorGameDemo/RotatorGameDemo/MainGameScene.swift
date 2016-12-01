//
//  MainGameScene.swift
//  RotatorGameDemo
//
//  Created by BW on 11/30/16.
//  Copyright © 2016 Wasted Potential. All rights reserved.
//

import UIKit
import SpriteKit


class MainGameScene: SKScene {

    
    
    override func didMoveToView(view: SKView) {
        let worldBorder = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody = worldBorder
        self.physicsBody?.friction = 1
        
        self.physicsWorld.gravity = CGVectorMake(0, -1)
        
    }
}
