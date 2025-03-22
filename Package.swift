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
            name: "AnsiEscapes",
            path: "Sources"),
        .executableTarget(name: "Link",
                dependencies: ["AnsiEscapes"],
                path: "Examples/Link"),
        .executableTarget(name: "MoveCursorTo",
                dependencies: ["AnsiEscapes"],
                path: "Examples/MoveCursorTo"),
        .executableTarget(name: "Image",
                dependencies: ["AnsiEscapes"],
                path: "Examples/Image"),
        .executableTarget(name: "iTermAnnotation",
                dependencies: ["AnsiEscapes"],
                path: "Examples/iTermAnnotation"),
        .executableTarget(name: "MoveCursorFor",
                dependencies: ["AnsiEscapes"],
                path: "Examples/MoveCursorFor"),
        .testTarget(
            name: "AnsiEscapesTests",
            dependencies: ["AnsiEscapes"]
        ),
    ]
)
