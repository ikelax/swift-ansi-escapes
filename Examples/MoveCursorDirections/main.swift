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
// We have to move backward first because moving
// the cursor backward also deletes printed characters.
// You can test this out by replacing `moveCursorForward`
// with `moveCursorBackward` and deleting the
// last print statement.
// Thus, we first print the bottom left x
// and after that move the cursor forward
// and print the bottom right x.
print(moveCursorBackward(for: 7), terminator: "")
print("x", terminator: "")
print(moveCursorForward(for: 5), terminator: "")
print("x")
