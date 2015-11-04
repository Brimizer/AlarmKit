![AlarmKit: Simple Alarms in Swift](https://raw.githubusercontent.com/Brimizer/AlarmKit/master/Assets/alarmkit_logo.png)

AlarmKit is a simple way to make clock based alarms in Swift. 
Great for making clock apps, scheduled notifications, and anything else that depends on code running at an exact time.

[![Version](https://img.shields.io/cocoapods/v/AlarmKit.svg?style=flat)](http://cocoapods.org/pods/AlarmKit)
[![License](https://img.shields.io/cocoapods/l/AlarmKit.svg?style=flat)](http://cocoapods.org/pods/AlarmKit)
[![Platform](https://img.shields.io/cocoapods/p/AlarmKit.svg?style=flat)](http://cocoapods.org/pods/AlarmKit)

```swift
let alarm = AlarmKit.Alarm(weekdays:[.Monday, .Wednesday, .Friday], hour:10, minute:45, {
  doSomethingHereEveryOtherDay()
})
```

## Installation

AlarmKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AlarmKit"
```

## Usage

### Creating a one-time alarm
```swift
let alarm = AlarmKit.Alarm(hour:10, minute:45, {
  doSomethingOnce()
})
```

### Creating a repeating alarm
```swift
let alarm = AlarmKit.Alarm(weekdays:[.Monday, .Wednesday, .Friday], hour:10, minute:45, {
  doSomethingHereEveryOtherDay()
})
```

### Changing the time
```swift
let alarm = AlarmKit.Alarm(hour:10, minute:45, {
  doSomethingHere()
})

alarm.hour = 9
alarm.minute = 0
```

### Changing the block
```swift
let alarm = AlarmKit.Alarm(hour:10, minute:45, {
  doSomethingHere()
})

alarm.block = {
  doSomethingElseInstead()
}
```

### Turning alarms off/on
```swift
let alarm = AlarmKit.Alarm(hour:10, minute:45, {
  doSomethingHere()
})

alarm.turnOff()
alarm.turnOn()
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Daniel Brim, brimizer@gmail.com

## License

AlarmKit is available under the MIT license. See the LICENSE file for more info.
