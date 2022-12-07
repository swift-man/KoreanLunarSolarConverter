//
//  KoreanSolarToLunarConverter.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

public final class KoreanSolarToLunarConverter {
  private let dataSource = KoreanLunarDataSource()
  private let lunarAlgorithm = KoreanLunarAlgorithm()
  private let solarAlgorithm = KoreanSolarAlgorithm()
  private let solarDateRangeChecker = SolarDateRangeChecker()
  
  public init() {
    
  }

  public func lunarDate(fromSolar solarDate: Date) throws -> KoreanDate {
    let dayLimit = solarAlgorithm.solarDays(year: solarDate.year, month: solarDate.month)
    guard
      solarDateRangeChecker.isValidDate(solarDate: solarDate, dayLimit: dayLimit)
    else { throw KoreanLunarConvertError.invalidDate }
    
    return lunarDate(fromSolarDate: solarDate)
  }
}

extension KoreanSolarToLunarConverter {
  private func lunarDate(fromSolarDate date: Date) -> KoreanDate {
    let solarYear = date.year
    let solarMonth = date.month
    let solarDay = date.day
    
    let absDays = solarAlgorithm.solarAbsDays(year: solarYear,
                                              month: solarMonth,
                                              day: solarDay)
    
    let lunarYear = makeLunarYear(fromSolarYear: solarYear, absDays: absDays)
    var lunarMonth = 0
    var lunarDay = 0
    var isIntercalation = false
    
    for month in stride(from: 12, through: 1, by: -1) {
      let absDaysByMonth = lunarAlgorithm.lunarAbsDays(year: lunarYear,
                                                       month: month,
                                                       day: 1,
                                                       isIntercalation: false)
      if absDays >= absDaysByMonth {
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
  
  private func makeLunarYear(fromSolarYear solarYear: Int, absDays: Int) -> Int {
    if absDays >= lunarAlgorithm.lunarAbsDays(year: solarYear,
                                              month: 1,
                                              day: 1,
                                              isIntercalation: false) {
      return solarYear
    }
    
    return solarYear - 1
  }
}
