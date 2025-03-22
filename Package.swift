// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "swift-ansi-escapes",
    platforms: [
      .macOS(.v13),
    ],
    products: [
        .library(
            name: "AnsiEscapes",
            targets: ["AnsiEscapes"]),
    ],
    targets: [
        .target(
            name: "AnsiEscapes"),
        .testTarget(
            name: "AnsiEscapesTests",
            dependencies: ["AnsiEscapes"]
        ),
    ]
)
