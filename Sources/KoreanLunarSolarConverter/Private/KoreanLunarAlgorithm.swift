//
//  KoreanLunarAlgorithm.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

final class KoreanLunarAlgorithm {
  private let dataSource = KoreanLunarDataSource()
  private var yearDaysCache: [Int: Int] = [:]
  
  /// Converts given lunar date to absolute days.
  ///
  /// - Parameters:
  ///   - year: The lunar year.
  ///   - month: The lunar month.
  ///   - day: The lunar day.
  ///   - isIntercalation: A boolean indicating if the month is an intercalation month.
  /// - Returns: The number of days since the base year.
  func lunarAbsDays(year: Int,
                    month: Int,
                    day: Int,
                    isIntercalation: Bool) -> Int {
    var days = lunarDaysBeforeBaseYear(year: year - 1) + lunarDaysBeforeBaseMonth(year: year,
                                                                                  month: month - 1,
                                                                                  isIntercalation: true) + day
    if isIntercalation && dataSource.lunarIntercalationMonth(lunar: dataSource.lunar(year: year)) == month {
      days += lunarDays(year: year, 
                        month: month,
                        isIntercalation: false)
    }
    return days
  }
  
  /// Returns the number of days in a given lunar year or month.
  ///
  /// - Parameters:
  ///   - year: The lunar year.
  ///   - month: (Optional) The lunar month.
  ///   - isIntercalation: (Optional) A boolean indicating if the month is an intercalation month.
  /// - Returns: The number of days.
  func lunarDays(year: Int,
                 month: Int? = nil,
                 isIntercalation: Bool? = nil) -> Int {
    let lunar = dataSource.lunar(year: year)
    
    guard
      let month,
      let isIntercalation
    else { return (lunar >> 17) & 0x01FF }
    
    let lunarSmallMonthDay = 29
    let lunarBigMonthDay = 30
    
    if isIntercalation && dataSource.lunarIntercalationMonth(lunar: lunar) == month {
      return ((lunar >> 16) & 0x01) > 0 ? lunarBigMonthDay : lunarSmallMonthDay
    }
    return ((lunar >> (12 - month)) & 0x01) > 0 ? lunarBigMonthDay : lunarSmallMonthDay
  }
}

extension KoreanLunarAlgorithm {
  /// Returns the number of days before the base year.
  ///
  /// - Parameter year: The lunar year.
  /// - Returns: The total number of days before the base year.
  private func lunarDaysBeforeBaseYear(year: Int) -> Int {
    if let cachedDays = yearDaysCache[year] {
      return cachedDays
    }
    
    var days = 0
    for baseYear in dataSource.lunarBaseYear ... year {
      days += lunarDays(year: baseYear)
    }
    
    yearDaysCache[year] = days
    return days
  }

  /// Returns the number of days before a given month in a given year.
  ///
  /// - Parameters:
  ///   - year: The lunar year.
  ///   - month: The lunar month.
  ///   - isIntercalation: A boolean indicating if the month is an intercalation month.
  /// - Returns: The total number of days before the given month.
  private func lunarDaysBeforeBaseMonth(year: Int, month: Int, isIntercalation: Bool) -> Int {
    var days = 0
    if year >= dataSource.lunarBaseYear && month > 0 {
      for baseMonth in 1 ... month {
        days += lunarDays(year: year, 
                          month: baseMonth,
                          isIntercalation: false)
      }
    }

    var intercalationMonth = 0
    if isIntercalation {
      intercalationMonth = dataSource.lunarIntercalationMonth(lunar: dataSource.lunar(year: year))
    }
    if intercalationMonth > 0 && intercalationMonth < month + 1 {
      days += lunarDays(year: year,
                        month: intercalationMonth,
                        isIntercalation: true)
    }
    return days
  }
}
