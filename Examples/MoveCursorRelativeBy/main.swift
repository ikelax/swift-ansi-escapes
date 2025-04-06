import AnsiEscapes

print(ANSIEscapeCode.clearTerminal())
print(ANSIEscapeCode.moveCursorTo(x: 5, y: 5), terminator: "")
print("1", terminator: "")
print(ANSIEscapeCode.moveCursorRelativeBy(x: -1, y: -5), terminator: "")
print("2", terminator: "")
print(ANSIEscapeCode.moveCursorRelativeBy(x: -6, y: 2), terminator: "")
print("3", terminator: "")
print(ANSIEscapeCode.moveCursorRelativeBy(x: 10), terminator: "")
print("4", terminator: "")
print(ANSIEscapeCode.moveCursorRelativeBy(x: 5, y: 5), terminator: "")
print("5", terminator: "")
