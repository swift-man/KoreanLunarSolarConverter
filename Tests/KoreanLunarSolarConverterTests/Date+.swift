//
//  Date+.swift
//  
//
//  Created by SwiftMan on 2023/02/12.
//

import Foundation

extension Date {
  static func === (lhs: Self, rhs: Self) -> Bool {
    return lhs.year == rhs.year &&
    lhs.month == rhs.month &&
    lhs.day == rhs.day
  }

  var calendar: Calendar { Calendar.current }

  var year: Int {
    get {
      return calendar.component(.year, from: self)
    }
    set {
      guard newValue > 0 else { return }
      let currentYear = calendar.component(.year, from: self)
      let yearsToAdd = newValue - currentYear
      if let date = calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
        self = date
      }
    }
  }

  /// SwifterSwift: Month.
  ///
  ///   Date().month -> 1
  ///
  ///   var someDate = Date()
  ///   someDate.month = 10 // sets someDate's month to 10.
  ///
  var month: Int {
    get {
      return calendar.component(.month, from: self)
    }
    set {
      let allowedRange = calendar.range(of: .month, in: .year, for: self)!
      guard allowedRange.contains(newValue) else { return }

      let currentMonth = calendar.component(.month, from: self)
      let monthsToAdd = newValue - currentMonth
      if let date = calendar.date(byAdding: .month, value: monthsToAdd, to: self) {
        self = date
      }
    }
  }

  /// SwifterSwift: Day.
  ///
  ///   Date().day -> 12
  ///
  ///   var someDate = Date()
  ///   someDate.day = 1 // sets someDate's day of month to 1.
  ///
  var day: Int {
    get {
      return calendar.component(.day, from: self)
    }
    set {
      let allowedRange = calendar.range(of: .day, in: .month, for: self)!
      guard allowedRange.contains(newValue) else { return }

      let currentDay = calendar.component(.day, from: self)
      let daysToAdd = newValue - currentDay
      if let date = calendar.date(byAdding: .day, value: daysToAdd, to: self) {
        self = date
      }
    }
  }
  
  /// SwifterSwift: Weekday.
  ///
  ///   Date().weekday -> 5 // fifth day in the current week.
  ///
  var weekday: Int {
    return calendar.component(.weekday, from: self)
  }
  
  /// SwifterSwift: Hour.
  ///
  ///   Date().hour -> 17 // 5 pm
  ///
  ///   var someDate = Date()
  ///   someDate.hour = 13 // sets someDate's hour to 1 pm.
  ///
  var hour: Int {
    get {
      return calendar.component(.hour, from: self)
    }
    set {
      let allowedRange = calendar.range(of: .hour, in: .day, for: self)!
      guard allowedRange.contains(newValue) else { return }
      
      let currentHour = calendar.component(.hour, from: self)
      let hoursToAdd = newValue - currentHour
      if let date = calendar.date(byAdding: .hour, value: hoursToAdd, to: self) {
        self = date
      }
    }
  }
  
  /// SwifterSwift: Minutes.
  ///
  ///   Date().minute -> 39
  ///
  ///   var someDate = Date()
  ///   someDate.minute = 10 // sets someDate's minutes to 10.
  ///
  var minute: Int {
    get {
      return calendar.component(.minute, from: self)
    }
    set {
      let allowedRange = calendar.range(of: .minute, in: .hour, for: self)!
      guard allowedRange.contains(newValue) else { return }
      
      let currentMinutes = calendar.component(.minute, from: self)
      let minutesToAdd = newValue - currentMinutes
      if let date = calendar.date(byAdding: .minute, value: minutesToAdd, to: self) {
        self = date
      }
    }
  }
  
  /// SwifterSwift: Seconds.
  ///
  ///   Date().second -> 55
  ///
  ///   var someDate = Date()
  ///   someDate.second = 15 // sets someDate's seconds to 15.
  ///
  var second: Int {
    get {
      return calendar.component(.second, from: self)
    }
    set {
      let allowedRange = calendar.range(of: .second, in: .minute, for: self)!
      guard allowedRange.contains(newValue) else { return }
      
      let currentSeconds = calendar.component(.second, from: self)
      let secondsToAdd = newValue - currentSeconds
      if let date = calendar.date(byAdding: .second, value: secondsToAdd, to: self) {
        self = date
      }
    }
  }
  
  /// SwifterSwift: Nanoseconds.
  ///
  ///   Date().nanosecond -> 981379985
  ///
  ///   var someDate = Date()
  ///   someDate.nanosecond = 981379985 // sets someDate's seconds to 981379985.
  ///
  var nanosecond: Int {
    get {
      return calendar.component(.nanosecond, from: self)
    }
    set {
#if targetEnvironment(macCatalyst)
      // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
      let allowedRange = 0..<1_000_000_000
#else
      let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
#endif
      guard allowedRange.contains(newValue) else { return }
      
      let currentNanoseconds = calendar.component(.nanosecond, from: self)
      let nanosecondsToAdd = newValue - currentNanoseconds
      
      if let date = calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) {
        self = date
      }
    }
  }
  
  /// SwifterSwift: Milliseconds.
  ///
  ///   Date().millisecond -> 68
  ///
  ///   var someDate = Date()
  ///   someDate.millisecond = 68 // sets someDate's nanosecond to 68000000.
  ///
  var millisecond: Int {
    get {
      return calendar.component(.nanosecond, from: self) / 1_000_000
    }
    set {
      let nanoSeconds = newValue * 1_000_000
#if targetEnvironment(macCatalyst)
      // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
      let allowedRange = 0..<1_000_000_000
#else
      let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
#endif
      guard allowedRange.contains(nanoSeconds) else { return }
      
      if let date = calendar.date(bySetting: .nanosecond, value: nanoSeconds, of: self) {
        self = date
      }
    }
  }
}
