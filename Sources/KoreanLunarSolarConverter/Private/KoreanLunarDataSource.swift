//
//  KoreanLunarDataSource.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation
import SQLite3

final class KoreanLunarDataSource {
  let lunarBaseYear = 1000
  private var db: OpaquePointer?

  init() throws {
    guard
        let url = Bundle.module
      .url(forResource: "lunar_calendar", withExtension: "sqlite")
    else {
      throw KoreanLunarConvertError.sqliteOpenError
    }

    if sqlite3_open(url.absoluteString, &db) != SQLITE_OK {
      defer { sqlite3_close(db) }
      throw KoreanLunarConvertError.sqliteOpenError
    }
  }

  func fetchLunarBySolar(
    solYear: Int,
    solMonth: Int,
    solDay: Int
  ) throws -> LunarDate {

    let sql = """
      SELECT
        lunYear, lunMonth, lunDay, lunLeapmonth
      FROM LunarCalendar
      WHERE solYear = ? AND solMonth = ? AND solDay = ?
      """

    var stmt: OpaquePointer?
    guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
      throw KoreanLunarConvertError.sqlitePrepareFetchError
    }
    defer { sqlite3_finalize(stmt) }

    sqlite3_bind_int(stmt, 1, Int32(solYear))
    sqlite3_bind_int(stmt, 2, Int32(solMonth))
    sqlite3_bind_int(stmt, 3, Int32(solDay))

    let step = sqlite3_step(stmt)

    guard step == SQLITE_ROW else {
      throw KoreanLunarConvertError.emptyResult
    }

    return LunarDate(
      year: Int(sqlite3_column_int(stmt, 0)),
      month: Int(sqlite3_column_int(stmt, 1)),
      day: Int(sqlite3_column_int(stmt, 2)),
      isIntercalation: (Int(sqlite3_column_int(stmt, 3)) == 1)
    )
  }

  func fetchSolarByLunar(
    lunYear: Int,
    lunMonth: Int,
    lunDay: Int
  ) throws -> [Date] {

    let sql = """
      SELECT
        solYear, solMonth, solDay, solLeapyear
      FROM LunarCalendar
      WHERE lunYear = ? AND lunMonth = ? AND lunDay = ?
      """

    var stmt: OpaquePointer?
    guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
      throw KoreanLunarConvertError.sqlitePrepareFetchError
    }
    defer { sqlite3_finalize(stmt) }

    sqlite3_bind_int(stmt, 1, Int32(lunYear))
    sqlite3_bind_int(stmt, 2, Int32(lunMonth))
    sqlite3_bind_int(stmt, 3, Int32(lunDay))

    var results: [Date] = []

    while sqlite3_step(stmt) == SQLITE_ROW {
      var date = Date()
      date.year = Int(sqlite3_column_int(stmt, 0))
      date.month = Int(sqlite3_column_int(stmt, 1))
      date.day = Int(sqlite3_column_int(stmt, 2))

      results.append(date)
    }

    return results
  }

  func fetchZodiac(
    lunYear: Int,
    lunMonth: Int,
    lunDay: Int
  ) throws -> [String] {
    func getText(_ idx: Int32) -> String? {
      guard let cStr = sqlite3_column_text(stmt, idx) else {
        return nil
      }
      return String(cString: cStr)
    }

    let sql = """
      SELECT
        lunSecha, lunWolgeon, lunIljin
      FROM LunarCalendar
      WHERE lunYear = ? AND lunMonth = ? AND lunDay = ?
      """

    var stmt: OpaquePointer?
    guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
      throw KoreanLunarConvertError.sqlitePrepareFetchError
    }
    defer { sqlite3_finalize(stmt) }

    sqlite3_bind_int(stmt, 1, Int32(lunYear))
    sqlite3_bind_int(stmt, 2, Int32(lunMonth))
    sqlite3_bind_int(stmt, 3, Int32(lunDay))

    var results: [String] = []

    while sqlite3_step(stmt) == SQLITE_ROW {
      guard
        let secha = getText(0),
        let wolgeon = getText(1),
        let iljin = getText(2)
      else { throw KoreanLunarConvertError.invalidZodiac }

      let zodiac = "\(secha)년 \(wolgeon)월 \(iljin)일"

      results.append(zodiac)
    }

    return results
  }

  func fetchZodiac(
    solYear: Int,
    solMonth: Int,
    solDay: Int
  ) throws -> String {

    let sql = """
      SELECT
        lunSecha, lunWolgeon, lunIljin
      FROM LunarCalendar
      WHERE solYear = ? AND solMonth = ? AND solDay = ?
      LIMIT 1;
      """

    var stmt: OpaquePointer?
    guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
      throw KoreanLunarConvertError.sqlitePrepareFetchError
    }
    defer { sqlite3_finalize(stmt) }

    sqlite3_bind_int(stmt, 1, Int32(solYear))
    sqlite3_bind_int(stmt, 2, Int32(solMonth))
    sqlite3_bind_int(stmt, 3, Int32(solDay))

    let step = sqlite3_step(stmt)

    guard step == SQLITE_ROW else {
      throw KoreanLunarConvertError.emptyResult
    }

    func getText(_ idx: Int32) -> String? {
      guard let cStr = sqlite3_column_text(stmt, idx) else {
        return nil
      }
      return String(cString: cStr)
    }

    guard
      let secha = getText(0),
      let wolgeon = getText(1),
      let iljin = getText(2)
    else { throw KoreanLunarConvertError.invalidZodiac }

    return "\(secha)년 \(wolgeon)월 \(iljin)일"
  }
}
