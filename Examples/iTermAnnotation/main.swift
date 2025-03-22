import AnsiEscapes

print(clearTerminal())

print(annotationiTerm(message: "Hello, world!", options: try! iTermAnnotationOptions(x: 0, y: 0, length: 0, isHidden: false)))
