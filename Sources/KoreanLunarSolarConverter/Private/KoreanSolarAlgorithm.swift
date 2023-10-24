//
//  KoreanSolarAlgorithm.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

final class KoreanSolarAlgorithm {
  private let dataSource = KoreanLunarDataSource()
  
  /// Calculates the absolute solar days for a given date by taking into account the solar and lunar differences.
  /// - Parameters:
  ///   - year: The specified year for calculation.
  ///   - month: The specified month for calculation.
  ///   - day: The specified day of the month.
  /// - Returns: The absolute solar days for the given date.
  func solarAbsDays(year: Int,
                    month: Int,
                    day: Int) -> Int {
    let solarLunarDayDiff = 43
    
    var days = solarDaysBeforeThisYear(year: year) + solarDaysBeforeThisMonth(year: year, month: month) + day
    days -= solarLunarDayDiff
    return days
  }
  
  /// Returns the number of solar days in a given year or in a specific month of that year.
  /// - Parameters:
  ///   - year: The specified year for calculation.
  ///   - month: (Optional) The specified month for calculation.
  /// - Returns: The number of solar days.
  func solarDays(year: Int,
                 month: Int? = nil) -> Int {
    if let unwrappedMonth = month {
      return daysInMonth(year: year, month: unwrappedMonth)
    }
    return totalDaysInYear(year: year)
  }
}

extension KoreanSolarAlgorithm {
  /// Returns the number of days in a specific month, taking into account leap years.
  /// - Parameters:
  ///   - year: The specified year for calculation.
  ///   - month: The specified month for calculation.
  /// - Returns: The number of days in the month.
  private func daysInMonth(year: Int, month: Int) -> Int {
    let commonYearMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    if month == 2 && isSolarIntercalationYear(year: year) {
      return 29
    }
    return commonYearMonths[month - 1]
  }
  
  /// Returns the total number of days in a given year, taking into account leap years.
  /// - Parameter year: The specified year for calculation.
  /// - Returns: The total number of days in the year.
  private func totalDaysInYear(year: Int) -> Int {
    return isSolarIntercalationYear(year: year) ? 366 : 365
  }
  
  /// Calculates the number of solar days that occurred before the given year.
  /// - Parameter year: The specified year for calculation.
  /// - Returns: The number of solar days before the given year.
  private func solarDaysBeforeThisYear(year: Int) -> Int {
    return (dataSource.lunarBaseYear..<year).reduce(0) { $0 + solarDays(year: $1) }
  }
  
  /// Calculates the number of solar days that occurred before the given month in the specified year.
  /// - Parameters:
  ///   - year: The specified year for calculation.
  ///   - month: The specified month for calculation.
  /// - Returns: The number of solar days before the given month.
  private func solarDaysBeforeThisMonth(year: Int, month: Int) -> Int {
    return (1..<month).reduce(0) { $0 + daysInMonth(year: year, month: $1) }
  }
  
  /// Determines if the given year is a leap year based on lunar data.
  /// - Parameter year: The specified year for checking.
  /// - Returns: A boolean indicating whether the year is a leap year.
  private func isSolarIntercalationYear(year: Int) -> Bool {
    let lunar = dataSource.lunar(year: year)
    return (lunar >> 30) & 0x01 > 0
  }
}
