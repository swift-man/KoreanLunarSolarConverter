//
//  KoreanSolarDateRangeChecker.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// Represents a checker for Korean solar dates to ensure they fall within a specific range and are valid.
public final class KoreanSolarDateRangeChecker {
  
  /// An instance of the algorithm used to calculate solar days.
  private let algorithm = KoreanSolarAlgorithm()
  
  /// Represents the minimum date that is considered valid for checking.
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
  
  /// Represents the maximum date that is considered valid for checking.
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
  
  /// Represents the valid range of dates between `minDate` and `maxDate`.
  private lazy var validRange: ClosedRange<Date> = {
    minDate ... maxDate
  }()
  
  /// Initializes an instance of `KoreanSolarDateRangeChecker`.
  public init() {}
  
  /// Checks if a given solar date is valid based on its placement within the valid range and its day.
  ///
  /// - Parameter solarDate: The solar date to be checked for validity.
  /// - Returns: A Boolean value indicating whether the provided solar date is valid.
  public func isValidDate(solarDate: Date) -> Bool {
    // Ensure the solar date falls within the valid range.
    guard validRange.contains(solarDate) else { return false }
    
    // Calculate the maximum number of days for the provided solar month and year.
    let dayLimit = algorithm.solarDays(year: solarDate.year, month: solarDate.month)
    
    // Check if the day of the solar date does not exceed the calculated day limit.
    return solarDate.day <= dayLimit
  }
}
