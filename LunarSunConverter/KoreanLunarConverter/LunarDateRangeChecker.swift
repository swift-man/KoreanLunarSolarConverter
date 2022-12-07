//
//  LunarDateRangeChecker.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

final class LunarDateRangeChecker {
  func isValidDate(lunarDate: Date, dayLimit: Int) -> Bool {
    let year = lunarDate.year
    let month = lunarDate.month
    let day = lunarDate.day
    
    let dateValue = year*10000 + month*100 + day

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
