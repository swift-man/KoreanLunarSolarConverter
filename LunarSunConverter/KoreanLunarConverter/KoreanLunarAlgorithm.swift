//
//  KoreanLunarAlgorithm.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

final class KoreanLunarAlgorithm {
  private let dataSource = KoreanLunarDataSource()
  
  func lunarAbsDays(year: Int,
                    month: Int,
                    day: Int,
                    isIntercalation: Bool) -> Int {
    var days = lunarDaysBeforeBaseYear(year: year - 1) + lunarDaysBeforeBaseMonth(year: year,
                                                                                  month: month - 1,
                                                                                  isIntercalation: true) + day
    if isIntercalation && dataSource.lunarIntercalationMonth(lunar: dataSource.lunar(year: year)) == month {
      days += lunarDays(year: year, month: month, isIntercalation: false)
    }
    return days
  }
  
  func lunarDays(year: Int,
                 month: Int? = nil,
                 isIntercalation: Bool? = nil) -> Int {
    let lunar = dataSource.lunar(year: year)

    guard
      let month,
      let isIntercalation
    else { return (lunar >> 17) & 0x01FF }

    if isIntercalation && dataSource.lunarIntercalationMonth(lunar: lunar) == month {
      return ((lunar >> 16) & 0x01) > 0 ? dataSource.lunarBigMonthDay : dataSource.lunarSmallMonthDay
    }
    return ((lunar >> (12 - month)) & 0x01) > 0 ? dataSource.lunarBigMonthDay : dataSource.lunarSmallMonthDay
  }
}

extension KoreanLunarAlgorithm {
  private func lunarDaysBeforeBaseYear(year: Int) -> Int {
    var days = 0
    for baseYear in dataSource.lunarBaseYear ... year {
      days += lunarDays(year: baseYear)
    }
    return days
  }

  private func lunarDaysBeforeBaseMonth(year: Int, month: Int, isIntercalation: Bool) -> Int {
    var days = 0
    if year >= dataSource.lunarBaseYear && month > 0 {
      for baseMonth in 1 ... month {
        days += lunarDays(year: year, month: baseMonth, isIntercalation: false)
      }
    }

    var intercalationMonth = 0
    if isIntercalation {
      intercalationMonth = dataSource.lunarIntercalationMonth(lunar: dataSource.lunar(year: year))
    }
    if intercalationMonth > 0 && intercalationMonth < month + 1 {
      days += lunarDays(year: year, month: intercalationMonth, isIntercalation: true)
    }
    return days
  }
}
