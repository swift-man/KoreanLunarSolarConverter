// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "KoreanLunarSolarConverter",
  platforms: [
    .iOS(.v12),
    .macOS(.v12),
    .tvOS(.v12),
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
      resources: [
        .process("Resources")
      ]),
    .testTarget(
      name: "KoreanLunarSolarConverterTests",
      dependencies: ["KoreanLunarSolarConverter"]),
  ]
)
