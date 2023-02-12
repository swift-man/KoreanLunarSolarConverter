//
//  LunarDateRangeChecker.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

public final class LunarDateRangeChecker {
  public init() {
    
  }
  
  public func isValidDate(lunarDate: Date) -> Bool {
    var minDate: Date {
      var date = Date()
      date.year = 1000
      date.month = 1
      date.day = 1
      date.hour = 0
      date.minute = 0
      date.second = 0
      date.nanosecond = 0
      date.millisecond = 0
      return date
    }
    
    var maxDate: Date {
      var date = Date()
      date.year = 2050
      date.month = 11
      date.day = 19
      date.hour = 0
      date.minute = 0
      date.second = 0
      date.nanosecond = 0
      date.millisecond = 0
      return date
    }
    
    var validRange: ClosedRange<Date> {
      minDate ... maxDate
    }
    
    let year = lunarDate.year
    let month = lunarDate.month
    let day = lunarDate.day

    guard validRange.contains(lunarDate) else { return false }
    
    let dayLimit = KoreanLunarAlgorithm().lunarDays(year: year,
                                                    month: month,
                                                    isIntercalation: true)
    
    return day <= dayLimit
  }
}
