//
//  ViewController.swift
//  ev3ios
//
//  Created by Takehiko YOSHIDA on 2017/03/01.
//  Copyright © 2017年 Takehiko YOSHIDA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnConnect: UIButton!
    @IBOutlet weak var btnTone: UIButton!
    @IBOutlet weak var btnRunMotors: UIButton!
    @IBOutlet weak var btnStopMotors: UIButton!
    @IBOutlet weak var btnBatteryLevel: UIButton!
    @IBOutlet weak var labAlert: UILabel!
    
    var robotConnection : RobotConnection = RobotConnection()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.btnTone.isEnabled = false
        self.btnRunMotors.isEnabled = false
        self.btnStopMotors.isEnabled = false
        self.btnBatteryLevel.isEnabled = false
        self.labAlert.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchConnect(_ sender: UIButton) {
        print("connect")
        let result = self.robotConnection.setup()
        if result {
            self.btnConnect.isEnabled = false
            self.btnTone.isEnabled = true
            self.btnRunMotors.isEnabled = true
            self.btnStopMotors.isEnabled = true
            self.btnBatteryLevel.isEnabled = true
            self.labAlert.isHidden = true
        } else {
            self.labAlert.isHidden = false
        }
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
    
    @IBAction func batteryLevel(_ sender: Any) {
        print("battery level")
        self.robotConnection.brick?.directCommand.getBatteryLevel{ [weak self] (level) in
            guard let level = level else { return }
            let controller = UIAlertController(title: "Battery Level", message: "\(String(describing: level))", preferredStyle: UIAlertControllerStyle.alert)
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: {})
        }
    }
}

