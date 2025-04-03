import Testing
import AnsiEscapes

@Test("Informs iTerm2 of the current directory /Users") func setCurrentDir() {
  #expect(ANSIEscapeCode.iTerm.setCurrentDir("/Users") == "\(ANSIEscapeCode.OSC)1337;CurrentDir=/Users\(ANSIEscapeCode.BEL)")
}
