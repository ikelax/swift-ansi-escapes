import AnsiEscapes

print(clearTerminal())

// We want to print
//
// x     x
//
//
//
//
//
// x     x

print(moveCursorTo(x: 0), terminator: "")
print("x", terminator: "")
print(moveCursorForward(for: 5), terminator: "")
print("x", terminator: "")
// We want to have 5 empty lines between the xs.
// Therefore, we have to move down 6 lines.
print(moveCursorDown(for: 6), terminator: "")
// We moved 5 forward and printed 2 characters.
// So, we have to move 7 backward.
print(moveCursorBackward(for: 7), terminator: "")
print("x", terminator: "")
print(moveCursorForward(for: 5), terminator: "")
print("x")
