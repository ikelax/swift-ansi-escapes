import Testing
import AnsiEscapes

@Test("Informs iTerm2 of the current directory /Users") func informCurrentDir() {
  #expect(ANSIEscapeCode.iTerm.informCurrentDir("/Users") == "\(ANSIEscapeCode.OSC)1337;CurrentDir=/Users\(ANSIEscapeCode.BEL)")
}
