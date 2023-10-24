//
//  LunarDateRangeChecker.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

public final class LunarDateRangeChecker {
  private let algorithm = KoreanLunarAlgorithm()
  
  private lazy var minDate: Date = {
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
  }()
  
  private lazy var maxDate: Date = {
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
  }()
  
  private lazy var validRange: ClosedRange<Date> = {
    minDate ... maxDate
  }()
  
  public init() {}
  
  public func isValidDate(lunarDate: Date) -> Bool {
    

    guard validRange.contains(lunarDate) else { return false }
    
    let dayLimit = algorithm.lunarDays(year: lunarDate.year,
                                       month: lunarDate.month,
                                       isIntercalation: true)
    
    return lunarDate.day <= dayLimit
  }
}
