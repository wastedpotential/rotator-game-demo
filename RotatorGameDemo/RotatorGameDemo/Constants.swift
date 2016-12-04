//
//  Constants.swift
//  RotatorGameDemo
//
//  Created by BW on 11/30/16.
//  Copyright © 2016 Wasted Potential. All rights reserved.
//

import UIKit

enum DeviceOrientation {
    case LandscapeLeft
    case LandscapeRight
    case Portrait
    case UpsideDown
    case FaceUp
    case FaceDown
}

enum PlayerMoveState {
    case Run
    case Fall
}

enum PlayerDirectionState {
    case FacingRight
    case FacingLeft
}

let gravity:CGFloat = 4.0
let runSpeed:CGFloat = 100

let unknownCategory:UInt32 = 0x1 << 0 //default value
let borderCategory:UInt32 = 0x1 << 1 //for testing collisions with the world border
let playerCategory:UInt32 = 0x1 << 2 //for testing collisions anywhere on player
let playerRightCategory:UInt32 = 0x1 << 3 //for testing collisions to player's right side
let playerLeftCategory:UInt32 = 0x1 << 4 //for testing collisions to player's left side
let playerBottomCategory:UInt32 = 0x1 << 5 //for testing collisions to player's bottom
