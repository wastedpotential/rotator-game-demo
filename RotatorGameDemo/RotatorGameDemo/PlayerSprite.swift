//
//  playerSprite.swift
//  RotatorGameDemo
//
//  Created by BW on 11/30/16.
//  Copyright © 2016 Wasted Potential. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerSprite: SKSpriteNode, SKPhysicsContactDelegate {

        
    var leftNode:SKSpriteNode?
    var rightNode:SKSpriteNode?
    var frontNode:SKSpriteNode? //switches between left and right
    var topNode:SKSpriteNode?
    var bottomNode:SKSpriteNode?

    //states with defaults for game start:
    var moveState:PlayerMoveState = .Fall
    var directionState: PlayerDirectionState = .FacingRight
    var deviceOrientation:DeviceOrientation = .LandscapeRight
    
    var playerFrontCategory:UInt32 = playerRightCategory
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        /*
        if let backNode:SKSpriteNode = self.childNodeWithName("backNode") as? SKSpriteNode {
            backPhysicsNode = backNode
        }
        if let frontNode:SKSpriteNode = self.childNodeWithName("frontNode") as? SKSpriteNode {
            frontPhysicsNode = frontNode
        }
        if let topNode:SKSpriteNode = self.childNodeWithName("topNode") as? SKSpriteNode {
            topPhysicsNode = topNode
        }
        if let bottomNode:SKSpriteNode = self.childNodeWithName("bottomNode") as? SKSpriteNode {
            bottomPhysicsNode = bottomNode
        }
 */
        

    }
    
    func ready() {
        guard let scene = self.scene as? MainGameScene else { return }
        
        scene.physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.allowsRotation = false
        
        //set up right contact detection:
        if let rightNode:SKSpriteNode = self.childNodeWithName("rightNode") as? SKSpriteNode {
            self.rightNode = rightNode
            rightNode.physicsBody = SKPhysicsBody(rectangleOfSize: rightNode.frame.size)
            rightNode.physicsBody?.categoryBitMask = playerRightCategory
            rightNode.physicsBody?.contactTestBitMask = borderCategory
            
            //pin the contact detector to the sprite
            let jointInSceneCoords = rightNode.position
            let myJoint = SKPhysicsJointFixed.jointWithBodyA(
                rightNode.physicsBody!,
                bodyB: self.physicsBody!,
                anchor: jointInSceneCoords )
            scene.physicsWorld.addJoint(myJoint)
            
            frontNode = rightNode
        }
        
        //why do I need this? I don't know.
        //set up left contact detection:
        if let leftNode:SKSpriteNode = self.childNodeWithName("leftNode") as? SKSpriteNode {
            self.leftNode = leftNode
            leftNode.physicsBody = SKPhysicsBody(rectangleOfSize: leftNode.frame.size)
            leftNode.physicsBody?.categoryBitMask = playerRightCategory
            leftNode.physicsBody?.contactTestBitMask = borderCategory
            
            //pin the contact detector to the sprite
            let jointInSceneCoords = leftNode.position
            let myJoint = SKPhysicsJointFixed.jointWithBodyA(
                leftNode.physicsBody!,
                bodyB: self.physicsBody!,
                anchor: jointInSceneCoords )
            scene.physicsWorld.addJoint(myJoint)
        }
        
        //set up bottom contact detection:
        if let bottomNode:SKSpriteNode = self.childNodeWithName("bottomNode") as? SKSpriteNode {
            self.bottomNode = bottomNode
            bottomNode.physicsBody = SKPhysicsBody(rectangleOfSize: bottomNode.frame.size)
            bottomNode.physicsBody?.categoryBitMask = playerBottomCategory
            bottomNode.physicsBody?.contactTestBitMask = borderCategory
            
            //pin the contact detector to the sprite
            let jointInSceneCoords = bottomNode.position
            let myJoint = SKPhysicsJointFixed.jointWithBodyA(
                bottomNode.physicsBody!,
                bodyB: self.physicsBody!,
                anchor: jointInSceneCoords )
            scene.physicsWorld.addJoint(myJoint)
        }
        
        

    }
    
    func rotateTo(orientation:DeviceOrientation) {
        deviceOrientation = orientation
        
        var angle:CGFloat = 0.0
        var shouldRotate = true
        switch orientation {
        case .Portrait:
            angle = 0.5*CGFloat(M_PI) - self.zRotation //rotate to 90 degrees
        case .UpsideDown:
            angle = -0.5*CGFloat(M_PI) - self.zRotation //rotate to -90 degrees
        case .LandscapeLeft:
            angle = CGFloat(M_PI) - self.zRotation //rotate to 180 degrees
        case .LandscapeRight:
            angle = 0.0 - self.zRotation //rotate to 0
        default:
            shouldRotate = false //do nothing
        }
        if shouldRotate {
            let rotateAction = SKAction.rotateByAngle(angle, duration: 0.2)
            self.runAction(rotateAction)
        }
    }
    
    func update() {
        if moveState == .Run {
            if deviceOrientation == .LandscapeRight {
                physicsBody?.velocity.dx = xScale*runSpeed
            }
            else if deviceOrientation == .LandscapeLeft {
                physicsBody?.velocity.dx = -1*xScale*runSpeed
            }
            else if deviceOrientation == .Portrait {
                physicsBody?.velocity.dy = xScale*runSpeed
            }
            else if deviceOrientation == .UpsideDown {
                physicsBody?.velocity.dy = -1*xScale*runSpeed
            }
        }
        else { //Stand or unknown:
            if deviceOrientation == .LandscapeRight || deviceOrientation == .LandscapeLeft {
                physicsBody?.velocity.dx = 0
            }
            else if deviceOrientation == .Portrait || deviceOrientation == .UpsideDown {
                physicsBody?.velocity.dy = 0
            }
        }
    }
    
    func switchDirection() {
        //why don't I need to swap the left and right nodes? I don't know
        if directionState == .FacingRight {
            directionState = .FacingLeft
            //frontNode = rightNode
            //playerFrontCategory = playerRightCategory
            xScale = -1
        }
        else {
            directionState = .FacingRight
            //frontNode = rightNode
            //playerFrontCategory = playerRightCategory
            xScale = 1
        }
    }
    
    
    //MARK: - SKPhysicsContactDelegate
    
    func didBeginContact(contact: SKPhysicsContact) {
        let collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
        
        if collision == (playerBottomCategory | borderCategory) {
            moveState = .Run
        }
        else if collision == (playerFrontCategory | borderCategory) {
            switchDirection()
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        let collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
        
        if collision == (playerBottomCategory | borderCategory) {
            moveState = .Fall
        }
    }
    
}
