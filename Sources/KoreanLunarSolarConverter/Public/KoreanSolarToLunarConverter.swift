//
//  KoreanSolarToLunarConverter.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// A converter class for transforming solar dates to lunar dates in Korean context.
public final class KoreanSolarToLunarConverter {
  private let dataSource = KoreanLunarDataSource()
  private let lunarAlgorithm = KoreanLunarAlgorithm()
  private let solarAlgorithm = KoreanSolarAlgorithm()
  private let solarDateRangeChecker = KoreanSolarDateRangeChecker()
  
  /// Initializes a new instance of the converter.
  public init() {}

  /// Transforms a given solar date into its corresponding lunar date.
  ///
  /// 음력 변환은 1000년 01월 01일 부터 2050년 11월 18일까지 지원
  /// 
  /// - Parameter solarDate: The solar date to be converted.
  /// - Returns: The corresponding Korean lunar date.
  /// - Throws: An error of type `KoreanLunarConvertError` if the solar date is not valid.
  public func lunarDate(fromSolar solarDate: Date) throws -> KoreanDate {
    guard solarDateRangeChecker.isValidDate(solarDate: solarDate)
    else { throw KoreanLunarConvertError.invalidDate }
    
    return lunarDate(fromSolarDate: solarDate)
  }
}

extension KoreanSolarToLunarConverter {
  /// Internal function to perform the actual conversion from solar to lunar date.
  /// - Parameter date: The solar date to be converted.
  /// - Returns: The corresponding lunar date.
  private func lunarDate(fromSolarDate date: Date) -> KoreanDate {
    let solarYear = date.year
    let solarMonth = date.month
    let solarDay = date.day
    
    let absDays = solarAlgorithm.solarAbsDays(year: solarYear,
                                              month: solarMonth,
                                              day: solarDay)
    
    let lunarYear = calculateLunarYear(fromSolarYear: solarYear, absDays: absDays)
    var lunarMonth = 0
    var lunarDay = 0
    var isIntercalation = false
    
    for month in stride(from: 12, through: 1, by: -1) {
      let currentAbsDays = lunarAlgorithm.lunarAbsDays(year: lunarYear,
                                                       month: month,
                                                       day: 1,
                                                       isIntercalation: false)
      
      if absDays >= currentAbsDays {
        lunarMonth = month
        if dataSource.lunarIntercalationMonth(year: lunarYear) == month {
          isIntercalation = absDays >= lunarAlgorithm.lunarAbsDays(year: lunarYear,
                                                                   month: month,
                                                                   day: 1,
                                                                   isIntercalation: true)
        }
        
        lunarDay = absDays - lunarAlgorithm.lunarAbsDays(year: lunarYear,
                                                         month: lunarMonth,
                                                         day: 1,
                                                         isIntercalation: isIntercalation) + 1
        break
      }
    }
    
    var lunarDate = Date()
    lunarDate.year = lunarYear
    lunarDate.month = lunarMonth
    lunarDate.day = lunarDay
    
    return KoreanDate(date: lunarDate, isIntercalation: isIntercalation)
  }
  
  /// Calculates the lunar year corresponding to a given solar year and its absolute days.
  /// - Parameters:
  ///   - solarYear: The solar year to be considered.
  ///   - absDays: The absolute days of the solar date.
  /// - Returns: The corresponding lunar year.
  private func calculateLunarYear(fromSolarYear solarYear: Int, absDays: Int) -> Int {
    if absDays >= lunarAlgorithm.lunarAbsDays(year: solarYear,
                                              month: 1,
                                              day: 1,
                                              isIntercalation: false) {
      return solarYear
    }
    
    return solarYear - 1
  }
}
