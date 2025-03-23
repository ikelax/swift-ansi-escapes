import AnsiEscapes

print(clearTerminal())
print(link(withText: "Repository", andUrl: "https://github.com/ikelax/swift-ansi-escapes"))
print(link(withText: "Open Users folder (works on macOS and Windows)", andUrl: "file:///Users"))
print(link(withText: "Open home folder (works on macOS and Linux)", andUrl: "file:///home"))
