// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KoreanLunarSolarConverter",
    products: [
        .library(
            name: "KoreanLunarSolarConverter",
            targets: ["KoreanLunarSolarConverter"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "KoreanLunarSolarConverter",
            dependencies: [],
            path: "Sources/KoreanLunarSolarConverter",
            exclude: ["Info.plist"]),
        .testTarget(
            name: "KoreanLunarSolarConverterTests",
            dependencies: ["KoreanLunarSolarConverter"],
            path: "Tests/KoreanLunarSolarConverterTests",
            exclude: ["Info.plist"]),
    ]
)
