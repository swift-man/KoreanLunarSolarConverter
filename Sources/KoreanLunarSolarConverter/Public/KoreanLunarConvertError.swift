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
  case removedGregorianDate
}

extension KoreanLunarConvertError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .invalidDate:
      return "제공된 음력 날짜가 유효하지 않습니다."
    case .removedGregorianDate:
      return "날짜가 제거된 그레고리력 날짜에 해당됩니다."
    }
  }
}
