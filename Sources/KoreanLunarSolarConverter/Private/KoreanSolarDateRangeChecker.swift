//
//  KoreanSolarDateRangeChecker.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// Represents a checker for Korean solar dates to ensure they fall within a specific range and are valid.
final class KoreanSolarDateRangeChecker {
  
  /// Represents the minimum date that is considered valid for checking.
  private lazy var minDate: Date = {
    var date = Date()
    date.year = 2016
    date.month = 1
    date.day = 1
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
    date.month = 12
    date.day = 31
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
  
  /// Initializes an instance of `KoreanSolarDateRangeChecker`.
  init() {}
  
  /// Checks if a given solar date is valid based on its placement within the valid range and its day.
  ///
  /// - Parameter solarDate: The solar date to be checked for validity.
  /// - Returns: A Boolean value indicating whether the provided solar date is valid.
  func isValidDate(solarDate: Date) -> Bool {
    return validRange.contains(solarDate)
  }
}
