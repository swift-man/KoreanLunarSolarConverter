# ``KoreanLunarSolarConverter``

Convert dates between the Gregorian calendar and the Korean lunar calendar.

## Overview

KoreanLunarSolarConverter provides offline date conversion based on Korean lunar calendar data.

The supported range is:

- Gregorian calendar: 1000-02-13 through 2050-12-31
- Korean lunar calendar: 1000-01-01 through 2050-11-18

## Convert Lunar Dates to Gregorian Dates

```swift
import KoreanLunarSolarConverter

let lunarDate = Date()
let converter = KoreanLunarToSolarConverter()
let solarDate = try converter.solarDate(fromLunar: lunarDate)
```

## Convert Gregorian Dates to Lunar Dates

```swift
import KoreanLunarSolarConverter

let solarDate = Date()
let converter = KoreanSolarToLunarConverter()
let lunarDate = try converter.lunarDate(fromSolar: solarDate)
```

## Format Korean Lunar Dates

```swift
import KoreanLunarSolarConverter

let formatter = KoreanLunarStringFormatter()
let lunarDateString = try formatter.lunarDateString(fromSolar: Date())
let lunarZodiac = try formatter.lunarZodiac(fromSolar: Date())
```

## Topics

### Conversion

- ``KoreanLunarToSolarConverter``
- ``KoreanSolarToLunarConverter``
- ``KoreanDate``

### Date Range Validation

- ``KoreanLunarDateRangeChecker``
- ``KoreanSolarDateRangeChecker``

### Formatting

- ``KoreanLunarStringFormatter``

### Errors

- ``KoreanLunarConvertError``
