//
//  KoreanLunarConverterError.swift
//  KoreanLunarConverter
//
//  Created by SwiftMan on 2022/12/07.
//

import Foundation

public enum KoreanLunarConverterError: Error {
  case invalidDate
  case absDayIsLessThanZero
}
