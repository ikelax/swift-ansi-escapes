import AnsiEscapes

print(ANSIEscapeCode.clearTerminal())

for i in 1..<10 {
  print(i)
}

print("10", terminator: "")

print(ANSIEscapeCode.eraseLines(count: 5), terminator: "")

print(6, terminator: "")

print("")
print("")

// Because of the newline after 10, the empty line
// at the end and the lines 10, 9, 8 and 7 are deleted.

for i in 1..<10 {
  print(i)
}

print("10")

print(ANSIEscapeCode.eraseLines(count: 5), terminator: "")

print("Hello", terminator: "")
