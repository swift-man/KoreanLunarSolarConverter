# KoreanLunarSolarConverter
=================================

한국 양음력 변환 - Swift

![Badge](https://img.shields.io/badge/swift-white.svg?style=flat-square&logo=Swift)
![Badge - Version](https://img.shields.io/badge/Version-0.7.3-1177AA?style=flat-square)
![Badge - Swift Package Manager](https://img.shields.io/badge/SPM-compatible-orange?style=flat-square)
![Badge - License](https://img.shields.io/badge/license-MIT-black?style=flat-square)
![Badge - Platform](https://img.shields.io/badge/macOS-v12.0-yellow?style=flat-square)
![Badge - Platform](https://img.shields.io/badge/iOS-v12.0-yellow?style=flat-square)
![Badge - Platform](https://img.shields.io/badge/tvOS-v12.0-yellow?style=flat-square)
![Badge - Platform](https://img.shields.io/badge/watchOS-v4.0-yellow?style=flat-square)

changed start year to support conversion from 1950


#### Overview

Here is a library to convert Korean lunar-calendar to Gregorian calendar.

Korean calendar and Chinese calendar is same lunar calendar but have different date.

This follow the KARI(Korea Astronomy and Space Science Institute)

한국 양음력 변환 ([한국천문연구원](https://astro.kasi.re.kr/life/pageView/8) 기준) - 네트워크 연결 불필요

```
Korean lunar-calendar (2016-01-01 ~ 2036-12-31)
```

## Documentation
[https://swift-man.github.io/KoreanLunarSolarConverter/documentation/koreanlunarsolarconverter](https://blog.slarea.com/KoreanLunarSolarConverter/documentation/koreanlunarsolarconverter/)

## Feature
- [ ] KoreanLunarStringFormatter.lunarDateString(fromLunar:)
- [ ] KoreanLunarStringFormatter.style `short`, `full` ...
- [ ] param date -> resultDate.midnight

#### Install

```
dependencies: [
    .package(url: "https://github.com/swift-man/KoreanLunarSolarConverter.git", .branch("main"))
]
```

#### To Use

(0) import module

```swift
import KoreanLunarConverter
```

(1) Korean Lunar Date -> Korean Solar Date (음력 -> 양력)

```swift
// Date to Date
let lunarDate: Date
let converter = KoreanLunarToSolarConverter()
let solar: [Date] = try? converter.solarDate(fromLunar: lunarDate)
```

(2) Korean Solar Date -> Korean Lunar Date (양력 -> 음력)

```swift
let solarDate: Date
let converter = KoreanSolarToLunarConverter()
let lunar: LunarDate = try? converter.lunarDate(fromSolar: solarDate)
```

(3) Korean Date String Format

```swift
let lunarDate: LunarDate // 20221204
let solarDate: Date // 20221226
let formetter = KoreanLunarStringFormatter()
formetter.lunarDateString(fromSolar: solarDate)) // 2022년 12월 4일(평달)
formetter.lunarZodiac(fromSolar: solarDate)) // 임인(壬寅)년 계축(癸丑)월 계축(癸丑)일
formetter.lunarZodiac(fromLunar: lunarDate)) // 임인(壬寅)년 계축(癸丑)월 계축(癸丑)일
```

(4) Result LunarDate

[나무위키 - 윤달](https://namu.wiki/w/%EC%9C%A4%EB%8B%AC)  

```swift
public struct LunarDate: Equatable {
  /// The actual date.
  public let year: Int
  public let month: Int
  public let day: Int
  /// Indicates if the date is an intercalation.
  public let isIntercalation: Bool
```

#### 참고 Extension
[SwifterSwift DateExtensions](https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/Foundation/DateExtensions.swift)
