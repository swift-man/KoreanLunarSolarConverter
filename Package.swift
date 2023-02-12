// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KoreanLunarSolarConverter",
    platforms: [
      .iOS(.v11),
      .macOS(.v11),
      .tvOS(.v11),
      .watchOS(.v4),
    ],
    products: [
        .library(
            name: "KoreanLunarSolarConverter",
            targets: ["KoreanLunarSolarConverter"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "KoreanLunarSolarConverter",
            dependencies: []),
        .testTarget(
            name: "KoreanLunarSolarConverterTests",
            dependencies: ["KoreanLunarSolarConverter"]),
    ]
)
