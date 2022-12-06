//
//  KoreanLunarConverter.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/06.
//

import Foundation

public struct KoreanDate {
  public var date: Date
  public var isIntercalation: Bool
  
  public init(date: Date, isIntercalation: Bool) {
    self.date = date
    self.isIntercalation = isIntercalation
  }
}

public final class KoreanLunarConverter {
  enum CalendarType {
    case lunar
    case solar
  }
  
  enum LimiteDate: Int {
    case lunarMin = 10000101
    case lunarMax = 20501118
    case solarMin = 10000213
    case solarMax = 20501231
    
    static func min(calendarType: CalendarType) -> LimiteDate {
      calendarType == .lunar ? .lunarMin : .solarMin
    }
    
    static func max(calendarType: CalendarType) -> LimiteDate {
      calendarType == .lunar ? .lunarMax : .solarMax
    }
  }
  
  private let dataSource = KoreanLunarDataSource()
  private let algorithm = KoreanLunarAlgorithm()
  
  public init() {
    
  }

  private func isSolarIntercalationYear(lunar: Int) -> Bool {
    return (lunar >> 30) & 0x01 > 0
  }

  private func solarDays(year: Int, month: Int? = nil) -> Int {
    let lunar = dataSource.lunar(year: year)
    if let month {
      let solarDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 29]
      return month == 2 && isSolarIntercalationYear(lunar: lunar) ? solarDays[12] : solarDays[month - 1]
    }

    return isSolarIntercalationYear(lunar: lunar) ? dataSource.solarBigYearDay : dataSource.solarSmallYearDay
  }

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

  private func solarAbsDays(year: Int,
                            month: Int,
                            day: Int) -> Int {
    var days = solarDaysBeforeBaseYear(year: year-1) + solarDaysBeforeBaseMonth(year: year, month: month-1) + day
    days -= dataSource.solarLunarDayDiff
    return days
  }

  private func solarDate(fromLunarDate date: Date, isIntercalation: Bool) -> Date {
    let lunarYear = date.year
    let absDays = algorithm.lunarAbsDays(year: lunarYear,
                                         month: date.month,
                                         day: date.day,
                                         isIntercalation: isIntercalation)
    var solarYear = 0
    var solarMonth = 0
    var solarDay = 0

    solarYear = absDays < solarAbsDays(year: lunarYear+1, month: 1, day: 1) ? lunarYear : lunarYear+1

    for month in stride(from: 12, through: 1, by: -1) {
      let absDaysByMonth = solarAbsDays(year: solarYear, month: month, day: 1)
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

  private func lunarDate(fromSolarDate date: Date) -> KoreanDate {
    let solarYear = date.year
    let solarMonth = date.month
    let solarDay = date.day
    
    
    let absDays = solarAbsDays(year: solarYear, month: solarMonth, day: solarDay)
    let lunarYear = absDays >= algorithm.lunarAbsDays(year: solarYear,
                                                      month: 1,
                                                      day: 1,
                                                      isIntercalation: false) ? solarYear : solarYear - 1
    var lunarMonth = 0
    var lunarDay = 0
    var isIntercalation = false
    
    for month in stride(from: 12, through: 1, by: -1) {
      let absDaysByMonth = algorithm.lunarAbsDays(year: lunarYear,
                                                  month: month,
                                                  day: 1,
                                                  isIntercalation: false)
      if absDays >= absDaysByMonth {
        lunarMonth = month
        if dataSource.lunarIntercalationMonth(lunar: dataSource.lunar(year: lunarYear)) == month {
          isIntercalation = absDays >= algorithm.lunarAbsDays(year: lunarYear,
                                                              month: month,
                                                              day: 1,
                                                              isIntercalation: true)
        }
        
        lunarDay = absDays - algorithm.lunarAbsDays(year: lunarYear,
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

  private func isValidDate(type: CalendarType,
                           isIntercalation: Bool,
                           date: Date) -> Bool {
    let year = date.year
    let month = date.month
    let day = date.day
    
    let dateValue = year*10000 + month*100 + day
    /// 1582. 10. 5 ~ 1582. 10. 14 is not valid
    
    let minValue = LimiteDate.min(calendarType: type).rawValue
    let maxValue = LimiteDate.max(calendarType: type).rawValue

    if minValue <= dateValue && maxValue >= dateValue {
      if month > 0 && month < 13 && day > 0 {
        var dayLimit: Int

        if type == .lunar {
          dayLimit = algorithm.lunarDays(year: year,
                                         month: month,
                                         isIntercalation: isIntercalation)
        } else {
          dayLimit = solarDays(year: year, month: month)
        }

        if type == .solar && year == 1582 && month == 10 {
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

  public func solarDate(fromLunar lunarDate: Date) throws -> KoreanDate {

    guard isValidDate(type: .lunar,
                      isIntercalation: true,
                      date: lunarDate)
    else { throw KoreanLunarConverterError.invalidDate }
    
    let lunar = dataSource.lunar(year: lunarDate.year)
    let isIntercalation = dataSource.lunarIntercalationMonth(lunar: lunar) == lunarDate.month
    let solarDate = solarDate(fromLunarDate: lunarDate, isIntercalation: isIntercalation)
    
    return KoreanDate(date: solarDate, isIntercalation: isIntercalation)
  }

  public func lunarDate(fromSolar solarDate: Date) throws -> KoreanDate {
    guard isValidDate(type: .solar,
                      isIntercalation: false,
                      date: solarDate)
    else { throw KoreanLunarConverterError.invalidDate }
    
    return lunarDate(fromSolarDate: solarDate)
  }
}
