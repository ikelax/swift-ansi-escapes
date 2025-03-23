import AnsiEscapes

print(ANSIEscapeCode.clearTerminal())
print(ANSIEscapeCode.link(withText: "Repository", andUrl: "https://github.com/ikelax/swift-ansi-escapes"))
print(ANSIEscapeCode.link(withText: "Open Users folder (works on macOS and Windows)", andUrl: "file:///Users"))
print(ANSIEscapeCode.link(withText: "Open home folder (works on macOS and Linux)", andUrl: "file:///home"))
