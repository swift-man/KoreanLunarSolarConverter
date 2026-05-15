//
//  KoreanLunarConvertError.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

/// An enumeration representing possible errors that can occur during Korean lunar date conversion.
public enum KoreanLunarConvertError: Error {
  /// Indicates that the provided date is invalid for lunar conversion.
  case invalidDate
  case emptyResult
  case sqlitePrepareFetchError
  case sqliteOpenError
  case invalidZodiac
}

extension KoreanLunarConvertError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .invalidDate:
      return "제공된 음력 날짜가 유효하지 않습니다."
    case .emptyResult:
      return "조회하려는 데이터가 없습니다."
    case .sqlitePrepareFetchError:
      return "조회 중 오류가 발생하였습니다."
    case .sqliteOpenError:
      return "sqlite 를 열 수 없습니다."
    case .invalidZodiac:
      return "데이터 형태 오류가 발생하였습니다."
    }
  }
}
