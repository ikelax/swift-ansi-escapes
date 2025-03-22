import AnsiEscapes

print(clearTerminal())
print(printLink(withText: "Repository", andUrl: "https://github.com/ikelax/swift-ansi-escapes"))
print(printLink(withText: "Open Users folder (works on macOS and Windows)", andUrl: "file:///Users"))
print(printLink(withText: "Open home folder (works on macOS and Linux)", andUrl: "file:///home"))
