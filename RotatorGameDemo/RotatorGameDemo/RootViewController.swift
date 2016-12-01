//
//  ViewController.swift
//  RotatorGameDemo
//
//  Created by BW on 11/28/16.
//  Copyright © 2016 Wasted Potential. All rights reserved.
//

import UIKit
import SpriteKit

class RootViewController: UIViewController {

    var myScene:SKScene?
    var myPlayer:PlayerSprite?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(interfaceDidRotate), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        //set up the scene:
        let skView = SKView(frame: self.view.frame)
        if let scene = SKScene(fileNamed: "MainGameScene") {
            skView.presentScene(scene)
            view.addSubview(skView)
            scene.physicsWorld.gravity = CGVectorMake(0, 0)
            myScene = scene
            
            if let player:PlayerSprite = scene.childNodeWithName("player") as? PlayerSprite {
                myPlayer = player
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func interfaceDidRotate() {
        switch UIDevice.currentDevice().orientation.rawValue {
        case 1:
            print("portrait")
            myScene?.physicsWorld.gravity = CGVectorMake(gravity, 0)
            myPlayer?.rotateTo(.Portrait)
        case 2:
            print("upside down")
            myScene?.physicsWorld.gravity = CGVectorMake(-1*gravity, 0)
            myPlayer?.rotateTo(.UpsideDown)
        case 3:
            print("landscape right")
            myScene?.physicsWorld.gravity = CGVectorMake(0, -1*gravity)
            myPlayer?.rotateTo(.LandscapeRight)
        case 4:
            print("landscape left")
            myScene?.physicsWorld.gravity = CGVectorMake(0, gravity)
            myPlayer?.rotateTo(.LandscapeLeft)
        case 5:
            print("face up")
            myScene?.physicsWorld.gravity = CGVectorMake(0, 0)
        case 6:
            print("face down")
            myScene?.physicsWorld.gravity = CGVectorMake(0, 0)
        default:
            print("unknown orientation")
            myScene?.physicsWorld.gravity = CGVectorMake(0, 0)
        }
    }
    
}

