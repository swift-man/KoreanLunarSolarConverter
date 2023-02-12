//
//  KoreanSolarAlgorithm.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

final class KoreanSolarAlgorithm {
  private let dataSource = KoreanLunarDataSource()
  
  func solarAbsDays(year: Int,
                    month: Int,
                    day: Int) -> Int {
    let solarLunarDayDiff = 43
    
    var days = solarDaysBeforeBaseYear(year: year-1) + solarDaysBeforeBaseMonth(year: year, month: month-1) + day
    days -= solarLunarDayDiff
    return days
  }
  
  func solarDays(year: Int, month: Int? = nil) -> Int {
    let lunar = dataSource.lunar(year: year)
    if let month {
      let solarDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 29]
      return month == 2 && isSolarIntercalationYear(lunar: lunar) ? solarDays[12] : solarDays[month - 1]
    }
    
    let solarSmallYearDay = 365
    let solarBigYearDay = 366

    return isSolarIntercalationYear(lunar: lunar) ? solarBigYearDay : solarSmallYearDay
  }
}

extension KoreanSolarAlgorithm {
  private func solarDaysBeforeBaseYear(year: Int) -> Int {
    var days = 0
    for baseYear in dataSource.lunarBaseYear ..< year + 1 {
      days += solarDays(year: baseYear)
    }
    return days
  }

  private func solarDaysBeforeBaseMonth(year: Int, month: Int) -> Int {
    var days = 0
    for baseMonth in 1 ..< month + 1 {
      days += solarDays(year: year, month: baseMonth)
    }
    return days
  }
  
  private func isSolarIntercalationYear(lunar: Int) -> Bool {
    return (lunar >> 30) & 0x01 > 0
  }
}
