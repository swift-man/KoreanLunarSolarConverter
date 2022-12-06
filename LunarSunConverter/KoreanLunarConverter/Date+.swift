//
//  Date+.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
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
}
