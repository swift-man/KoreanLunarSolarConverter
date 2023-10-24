//
//  SolarDateRangeChecker.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

public final class SolarDateRangeChecker {
  private lazy var minDate: Date = {
    var date = Date()
    date.year = 1000
    date.month = 2
    date.day = 13
    date.hour = 0
    date.minute = 0
    date.second = 0
    date.nanosecond = 0
    date.millisecond = 0
    return date
  }()
  
  private lazy var maxDate: Date = {
    var date = Date()
    date.year = 2051
    date.month = 1
    date.day = 1
    date.hour = 0
    date.minute = 0
    date.second = 0
    date.nanosecond = 0
    date.millisecond = 0
    return date
  }()
  
  private let algorithm = KoreanSolarAlgorithm()
  
  private lazy var validRange: ClosedRange<Date> = {
    minDate ... maxDate
  }()
  
  public init() {
    
  }
  
  public func isValidDate(solarDate: Date) -> Bool {
    guard validRange.contains(solarDate) else { return false }
    
    let dayLimit = algorithm.solarDays(year: solarDate.year, month: solarDate.month)
    
    return solarDate.day <= dayLimit
  }
}
