import AnsiEscapes

print(ANSIEscapeCode.clearTerminal())

print("Hi!", terminator: "")
print(
  ANSIEscapeCode.iTerm.annotation(
    message: "Hi, back!", options: try! iTermAnnotationOptions(x: 0, y: 1, length: 3)))

print("")
print("")

print("Wǎn shàng hǎo", terminator: "")
print(
  ANSIEscapeCode.iTerm.annotation(
    message: "Wǎn shàng hǎo", options: try! iTermAnnotationOptions(length: 1)))

print("")
print("")

print("こんにちは", terminator: "")
print(ANSIEscapeCode.iTerm.annotation(message: "こんにちは", options: try! iTermAnnotationOptions()))

print("")
print("")

print("To see the hidden annotation: Right click > Reveal Annotation.", terminator: "")
print(
  ANSIEscapeCode.iTerm.annotation(
    message: "Now, you see it :)", options: try! iTermAnnotationOptions(isHidden: true)))
