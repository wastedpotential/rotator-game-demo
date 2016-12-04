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

    
    var player:PlayerSprite?
    var playerFront:SKSpriteNode = SKSpriteNode()
    var playerBottom:SKSpriteNode = SKSpriteNode()
    var count = 0
    
    var playerState:PlayerMoveState = .Fall
    
    
    override func didMoveToView(view: SKView) {
        
        let worldBorder = SKPhysicsBody(edgeLoopFromRect: self.frame)
        physicsBody = worldBorder
        physicsBody?.friction = 1
        physicsBody?.categoryBitMask = borderCategory
        
        physicsWorld.gravity = CGVectorMake(0, -1)
        
        if let player:PlayerSprite = self.childNodeWithName("player") as? PlayerSprite {
            self.player = player
            player.ready()
        }
    }
    
    
    override func update(currentTime: NSTimeInterval) {
        player?.update()
    }
    
    
}
