# swift-ansi-escapes

> ANSI escape codes for manipulating the terminal.

Port of [ansi-escapes](https://github.com/sindresorhus/ansi-escapes)
from [sindresorhus](https://github.com/sindresorhus) to Swift.

Most of the escape codes are taken from
[here](https://www2.ccs.neu.edu/research/gpc/VonaUtils/vona/terminal/vtansi.htm).
But currently, not all of them are supported.

## Installation

You can install swift-ansi-escapes using the Swift Package Manager. To
add it to your Xcode project, go to File > Swift Packages > Add Package
Dependency and enter the URL of this repository.

You can also add it to a standalone Swift package by adding it to your
`Package.swift` file:

```swift
let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/ikelax/swift-ansi-escapes.git", from: "TODO")
    ],
    targets: [
        .target(
            name: "MyPackage",
            dependencies: ["AnsiEscapes"])
    ]
)
```

## Usage

## License

swift-ansi-escapes is available under the MIT license. See the [LICENSE]
file for more info.
