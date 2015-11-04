//
// AlarmKit.swift
//
// Copyright (c) 2015 Daniel Brim <brimizer@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public enum Weekday:NSInteger {
    case Sunday = 1
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
}

public class Alarm: NSObject {
    public var hour: Int
    public var minute: Int
    public var weekdays: [Weekday]?
    public var isOn: Bool = true
    public var block: () -> ()

    private var timer: NSTimer?
    private var repeats: Bool = false
    
    // If you don't know the time yet, then create a time-less alarm.
    // It will be off by default. You must call turnOn() after setting a time.
    public override init() {
        self.hour = 0
        self.minute = 0
        self.block = {}
        self.repeats = false
        
        super.init()
    }
    
    // If you don't know the time yet, then create a time-less alarm.
    // It will be off by default. You must call turnOn() after setting a time.
    public convenience init(_ block: () -> ()) {
        
        self.init()
        
        self.block = block
        self.repeats = false
    }

    public convenience init(weekdays:[Weekday], hour:Int, minute:Int, _ block: () -> ()) {

        self.init()
        
        self.hour = hour
        self.minute = minute
        self.weekdays = weekdays
        self.block = block
        self.repeats = true

        self.turnOn()
    }

    public convenience init(hour:Int, minute:Int, _ block: () -> ()) {

        self.init()
        
        self.hour = hour
        self.minute = minute
        self.block = block
        self.repeats = false

        self.turnOn()
    }
    

    /// Returns a tuple of (weekay, hour, minute, second) of the current date/time
    private func currentDateComponents() -> (Int, Int, Int, Int) {
        let now = NSDate()
        let flags = NSCalendarUnit.Weekday.union(NSCalendarUnit.Hour).union(NSCalendarUnit.Minute).union(NSCalendarUnit.Second)
        let comps = NSCalendar.currentCalendar().components(flags, fromDate: now)
        return (comps.weekday, comps.hour, comps.minute, comps.second)
    }

    private func checkUpdate() {

        let (weekday, hour, minute, second) = currentDateComponents()

        // Only continue if this alarm doesn't repeat and is a one-time-use alarm
        // Or if it does repeat, and today is the correct day
        guard (!self.repeats || self.weekdays?.contains(Weekday(rawValue:weekday)!) == true) else {
            return
        }

        // Now check the hour and minute
        if hour == self.hour && minute == self.minute && second == 0 {
            // If so, call the callback
            self.block()

            // If this alarm is one time use, turn it off
            if !self.repeats {
                self.turnOff()
            }
        }
    }

    public func turnOn() {
        guard self.timer == nil || self.timer?.valid == false else {
            self.isOn = true
            return
        }

        self.timer?.invalidate() // Invalidate, just in case
        self.timer = NSTimer.every(1.0, checkUpdate)
        self.isOn = true
    }

    public func turnOff() {
        self.timer?.invalidate()
        self.isOn = false
    }
}

private class NSTimerActor {
    let block: () -> Void

    init(_ block: () -> Void) {
        self.block = block
    }

    @objc func fire() {
        block()
    }
}

private extension NSTimer {
    private class func new(every interval: NSTimeInterval, _ block: () -> ()) -> NSTimer {
        let actor = NSTimerActor(block)
        return self.init(timeInterval: interval, target: actor, selector: "fire", userInfo: nil, repeats: true)
    }

    private func start(runLoop runLoop: NSRunLoop = NSRunLoop.currentRunLoop(), modes: String...) {
        let modes = modes.isEmpty ? [NSDefaultRunLoopMode] : modes

        for mode in modes {
            runLoop.addTimer(self, forMode: mode)
        }
    }

    private class func every(interval:NSTimeInterval, _ block: () -> ()) -> NSTimer {
        let timer = NSTimer.new(every: interval, block)
        timer.start()
        return timer
    }
}
