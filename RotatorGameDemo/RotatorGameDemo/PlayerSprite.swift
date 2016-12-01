//
//  playerSprite.swift
//  RotatorGameDemo
//
//  Created by BW on 11/30/16.
//  Copyright © 2016 Wasted Potential. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerSprite: SKSpriteNode {

    //
    
    /*required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        print("herp")
    }*/
    
    func rotateTo(orientation:Orientation) {
        var angle:CGFloat = 0.0
        var shouldRotate = true
        switch orientation {
        case .Portrait:
            angle = 0.5*CGFloat(M_PI) - self.zRotation
        case .UpsideDown:
            angle = -0.5*CGFloat(M_PI) - self.zRotation
        case .LandscapeLeft:
            angle = CGFloat(M_PI) - self.zRotation
        case .LandscapeRight:
            angle = 0.0 - self.zRotation
        default:
            shouldRotate = false
        }
        if shouldRotate {
            let rotateAction = SKAction.rotateByAngle(angle, duration: 0.2)
            //and just run the action
            self.runAction(rotateAction)
        }
    }
}
