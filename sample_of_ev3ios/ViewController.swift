//
//  ViewController.swift
//  ev3ios
//
//  Created by Takehiko YOSHIDA on 2017/03/01.
//  Copyright © 2017年 Takehiko YOSHIDA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var robotConnection : RobotConnection = RobotConnection()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.robotConnection.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchedTone(_ sender: UIButton) {
        print("play tone")
        self.robotConnection.brick?.directCommand.playTone(volume: 100, frequency: 550, duration: 500)
    }

    @IBAction func touchedRun(_ sender: UIButton) {
        print("run motors")
        self.robotConnection.brick?.directCommand.turnMotorAtPower(onPorts: .All, withPower: 75)
    }
    
    @IBAction func touchedStop(_ sender: UIButton) {
        print("stop motors")
        self.robotConnection.brick?.directCommand.stopMotor(onPorts: .All, withBrake: true)
    }
}

