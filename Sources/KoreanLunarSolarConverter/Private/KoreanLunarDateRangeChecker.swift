//
//  KoreanLunarDateRangeChecker.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// Represents a checker for Korean lunar dates to ensure they fall within a specific range and are valid.
final class KoreanLunarDateRangeChecker {
  
  /// Represents the minimum date that is considered valid for checking.
  private lazy var minDate: Date = {
    var date = Date()
    date.year = 2015
    date.month = 11
    date.day = 30
    date.hour = 0
    date.minute = 0
    date.second = 0
    date.nanosecond = 0
    date.millisecond = 0
    return date
  }()
  
  /// Represents the maximum date that is considered valid for checking.
  private lazy var maxDate: Date = {
    var date = Date()
    date.year = 2036
    date.month = 11
    date.day = 29
    date.hour = 0
    date.minute = 0
    date.second = 0
    date.nanosecond = 0
    date.millisecond = 0
    return date
  }()
  
  /// Represents the valid range of dates between `minDate` and `maxDate`.
  private lazy var validRange: ClosedRange<Date> = {
    minDate ... maxDate
  }()
  
  /// Initializes an instance of `KoreanLunarDateRangeChecker`.
  init() {}
  
  /// Checks if a given lunar date is valid based on its placement within the valid range and its day.
  ///
  /// - Parameter lunarDate: The lunar date to be checked for validity.
  /// - Returns: A Boolean value indicating whether the provided lunar date is valid.
  func isValidDate(lunarDate: Date) -> Bool {
    return validRange.contains(lunarDate)
  }
}
