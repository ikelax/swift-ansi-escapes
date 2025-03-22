import AnsiEscapes

print(clearTerminal())

for i in 0..<10 {
  print(moveCursorTo(x: i, y: i))
  print(String(i))
  print(moveCursorTo(x: i))
  print(String(i))
}
