import Testing
import AnsiEscapes

@Suite("Clears the terminal") struct ClearTerminal {
  @Test("on Windows") func windows() {
    #expect(ANSIEscapeCode.clearTerminal(onWindows: true) == "\(ANSIEscapeCode.EraseScreen)\(ANSIEscapeCode.ESC)0f")
  }
  
  @Test("on macOS or Linux") func macOSOrLinux() {
    #expect(ANSIEscapeCode.clearTerminal() == "\(ANSIEscapeCode.EraseScreen)\(ANSIEscapeCode.ESC)3J\(ANSIEscapeCode.ESC)H")
  }
}
