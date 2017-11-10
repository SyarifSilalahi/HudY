//
//  ViewController.swift
//  HudY
//
//  Created by SyarifSilalahi on 11/10/2017.
//  Copyright (c) 2017 SyarifSilalahi. All rights reserved.
//

import UIKit
import HudY

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func skype(_ sender: AnyObject) {
        HudY.show(.dotSpinningLikeSkype)
        //contoh delay
        let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            HudY.hide()
        }
    }
    @IBAction func triangle(_ sender: AnyObject) {
        HudY.show(.dotTrianglePath)
        //contoh delay
        let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            HudY.hide()
        }
    }
    @IBAction func dots(_ sender: AnyObject) {
        HudY.show(.funnyDotsA)
        //contoh delay
        let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            HudY.hide()
        }
    }
    @IBAction func line(_ sender: AnyObject) {
        HudY.show(.lineScale)
        //contoh delay
        let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            HudY.hide()
        }
    }
    @IBAction func circle(_ sender: AnyObject) {
        HudY.show(.rotatingCircle)
        //contoh delay
        let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            HudY.hide()
        }
    }
    @IBAction func spin(_ sender: AnyObject) {
        HudY.show(.spininngDot)
        //contoh delay
        let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            HudY.hide()
        }
    }
    @IBAction func gif(_ sender: AnyObject) {
        HudY.showGif("1.gif")
        //contoh delay
        let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            HudY.hide()
        }
    }
    @IBAction func video(_ sender: AnyObject) {
        HudY.showVideo("parabola")
        //contoh delay
        let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            HudY.hide()
        }
    }

}

