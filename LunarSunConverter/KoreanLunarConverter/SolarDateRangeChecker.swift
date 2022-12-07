//
//  SolarDateRangeChecker.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

final class SolarDateRangeChecker {
  func isValidDate(solarDate: Date,
                   dayLimit: Int) -> Bool {
    let year = solarDate.year
    let month = solarDate.month
    let day = solarDate.day
    
    let dateValue = year*10000 + month*100 + day
    
    let solarMin = 10000213
    let solarMax = 20501231

    if solarMin <= dateValue && solarMax >= dateValue {
      if month > 0 && month < 13 && day > 0 {
        var dayLimit = dayLimit

        /// 1582. 10. 5 ~ 1582. 10. 14 is not valid
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
