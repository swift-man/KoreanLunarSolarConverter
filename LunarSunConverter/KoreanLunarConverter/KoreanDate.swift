//
//  KoreanDate.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

public struct KoreanDate {
  public let date: Date
  public let isIntercalation: Bool
  
  public init(date: Date, isIntercalation: Bool) {
    self.date = date
    self.isIntercalation = isIntercalation
  }
}

final class SolarDateRangeChecker {
  func isValidDate(solarDate: Date,
                   dayLimit: Int) -> Bool {
    let year = solarDate.year
    let month = solarDate.month
    let day = solarDate.day
    
    let dateValue = year*10000 + month*100 + day
    /// 1582. 10. 5 ~ 1582. 10. 14 is not valid
    
    let solarMin = 10000213
    let solarMax = 20501231

    if solarMin <= dateValue && solarMax >= dateValue {
      if month > 0 && month < 13 && day > 0 {
        var dayLimit = dayLimit //solarDays(year: year, month: month)

        if year == 1582 && month == 10 {
          if day > 4 && day < 15 {
            return false
          } else {
            dayLimit += 10
          }
        }

        if day <= dayLimit {
          return true
        }
      }
    }

    return false
  }
}


final class LunarDateRangeChecker {
  func isValidDate(lunarDate: Date, dayLimit: Int) -> Bool {
    let year = lunarDate.year
    let month = lunarDate.month
    let day = lunarDate.day
    
    let dateValue = year*10000 + month*100 + day
    /// 1582. 10. 5 ~ 1582. 10. 14 is not valid
    
    let minValue = 10000101
    let maxValue = 20501118

    if minValue <= dateValue && maxValue >= dateValue {
      if month > 0 && month < 13 && day > 0 {
        if day <= dayLimit {
          return true
        }
      }
    }

    return false
  }
}
