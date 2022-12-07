//
//  KoreanLunarToSolarConverter.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

public final class KoreanLunarToSolarConverter {
  private let dataSource = KoreanLunarDataSource()
  private let lunarAlgorithm = KoreanLunarAlgorithm()
  private let solarAlgorithm = KoreanSolarAlgorithm()
  private let lunarDateRangeChecker = LunarDateRangeChecker()
  
  public init() {
    
  }

  public func solarDate(fromLunar lunarDate: Date) throws -> KoreanDate {
    let dayLimit = lunarAlgorithm.lunarDays(year: lunarDate.year,
                                            month: lunarDate.month,
                                            isIntercalation: true)
    guard
      lunarDateRangeChecker.isValidDate(lunarDate: lunarDate, dayLimit: dayLimit)
    else { throw KoreanLunarConvertError.invalidDate }

    let lunar = dataSource.lunar(year: lunarDate.year)
    let isIntercalation = dataSource.lunarIntercalationMonth(lunar: lunar) == lunarDate.month
    let solarDate = solarDate(fromLunarDate: lunarDate, isIntercalation: isIntercalation)

    return KoreanDate(date: solarDate, isIntercalation: isIntercalation)
  }
}

extension KoreanLunarToSolarConverter {
  private func solarDate(fromLunarDate date: Date, isIntercalation: Bool) -> Date {
    let lunarYear = date.year
    let absDays = lunarAlgorithm.lunarAbsDays(year: lunarYear,
                                              month: date.month,
                                              day: date.day,
                                              isIntercalation: isIntercalation)
    var solarYear = 0
    var solarMonth = 0
    var solarDay = 0

    solarYear = absDays < solarAlgorithm.solarAbsDays(year: lunarYear+1,
                                                      month: 1,
                                                      day: 1) ? lunarYear : lunarYear+1

    for month in stride(from: 12, through: 1, by: -1) {
      let absDaysByMonth = solarAlgorithm.solarAbsDays(year: solarYear,
                                                       month: month,
                                                       day: 1)
      if absDays >= absDaysByMonth {
        solarMonth = month
        solarDay = absDays - absDaysByMonth + 1
        break
      }
    }

    var solarDate = Date()
    solarDate.year = solarYear
    solarDate.month = solarMonth
    solarDate.day = solarDay

    return solarDate
  }
}
