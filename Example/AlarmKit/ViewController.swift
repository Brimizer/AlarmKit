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
    let alarm = Alarm(hour:Int, minute:Int, {
        
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.datePicker.addTarget(self, action: "timeChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timeChanged() {
        let hour:Int, minute = components(self.datePicker.date)
    }
    
    func components(date:NSDate) -> (Int, Int) {
        let flags = NSCalendarUnit.Hour.union(NSCalendarUnit.Minute)
        let comps = NSCalendar.currentCalendar().components(flags, fromDate: date)
        return (comps.hour, comps.minute)
    }
}

