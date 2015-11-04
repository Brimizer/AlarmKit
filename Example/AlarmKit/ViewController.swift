//
//  ViewController.swift
//  AlarmKit
//
//  Created by Daniel Brim on 11/03/2015.
//  Copyright (c) 2015 Daniel Brim. All rights reserved.
//

import UIKit
import AlarmKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var onSwitch: UISwitch!
    @IBOutlet weak var triggeredLabel: UILabel!
    
    var alarm: AlarmKit.Alarm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reset()
        
        // Create an alarm with a sensible default time 12:00pm
        self.alarm = AlarmKit.Alarm(hour:23, minute:39, {
            debugPrint("Alarm triggered!")
            self.triggeredLabel.text = "Alarm Triggered!"
        })
        
        self.datePicker.addTarget(self, action: "timeChanged", forControlEvents: UIControlEvents.ValueChanged)
        self.onSwitch.addTarget(self, action: "switchChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timeChanged() {
        let (hour, minute) = components(self.datePicker.date)
        
        // If we want, we can change the hour and minute after the alarm's creation
        self.alarm.hour = hour
        self.alarm.minute = minute
        
        reset()
    }
    
    func switchChanged() {
        if self.onSwitch.on {
            self.alarm.turnOn()
        } else {
            self.alarm.turnOff()
        }
    }
    
    ///MARK: Helpers
    func reset() {
        self.triggeredLabel.text = "Waiting..."
    }
    
    func components(date:NSDate) -> (Int, Int) {
        let flags = NSCalendarUnit.Hour.union(NSCalendarUnit.Minute)
        let comps = NSCalendar.currentCalendar().components(flags, fromDate: date)
        return (comps.hour, comps.minute)
    }
}

