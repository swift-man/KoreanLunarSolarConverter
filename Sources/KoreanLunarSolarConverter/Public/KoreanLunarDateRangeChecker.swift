//
//  KoreanLunarDateRangeChecker.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// Represents a checker for Korean lunar dates to ensure they fall within a specific range and are valid.
public final class KoreanLunarDateRangeChecker {
  
  /// An instance of the algorithm used to calculate lunar days.
  private let algorithm = KoreanLunarAlgorithm()
  
  /// Represents the minimum date that is considered valid for checking.
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
  
  /// Represents the maximum date that is considered valid for checking.
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
  
  /// Represents the valid range of dates between `minDate` and `maxDate`.
  private lazy var validRange: ClosedRange<Date> = {
    minDate ... maxDate
  }()
  
  /// Initializes an instance of `KoreanLunarDateRangeChecker`.
  public init() {}
  
  /// Checks if a given lunar date is valid based on its placement within the valid range and its day.
  ///
  /// - Parameter lunarDate: The lunar date to be checked for validity.
  /// - Returns: A Boolean value indicating whether the provided lunar date is valid.
  public func isValidDate(lunarDate: Date) -> Bool {
    // Ensure the lunar date falls within the valid range.
    guard validRange.contains(lunarDate) else { return false }
    
    // Calculate the maximum number of days for the provided lunar month and year.
    let dayLimit = algorithm.lunarDays(year: lunarDate.year,
                                       month: lunarDate.month,
                                       isIntercalation: true)
    
    // Check if the day of the lunar date does not exceed the calculated day limit.
    return lunarDate.day <= dayLimit
  }
}
