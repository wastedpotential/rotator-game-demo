//
//  ViewController.swift
//  RotatorGameDemo
//
//  Created by BW on 11/28/16.
//  Copyright © 2016 Wasted Potential. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(interfaceDidRotate), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func interfaceDidRotate() {
        switch UIDevice.currentDevice().orientation.rawValue {
        case 1:
            print("portrait")
        case 2:
            print("upside down")
        case 3:
            print("landscape right")
        case 4:
            print("landscape left")
        case 5:
            print("face up")
        case 6:
            print("face down")
        default:
            print("unknown orientation")
        }
    }
    
}

