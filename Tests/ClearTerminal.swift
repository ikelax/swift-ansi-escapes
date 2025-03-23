import Testing
import AnsiEscapes

@Suite("Clears the terminal") struct ClearTerminal {
  @Test("on Windows") func windows() {
    #if os(Windows)
    #expect(ANSIEscapeCode.clearTerminal() == "\(ANSIEscapeCodes.EraseScreen)\(ANSIEscapeCodes.ESC)0f")
    #endif
  }
  
  @Test("on Linux") func linux() {
    #if os(Linux)
    #expect(ANSIEscapeCode.clearTerminal() == "\(ANSIEscapeCode.EraseScreen)\(ANSIEscapeCode.ESC)3J\(ANSIEscapeCode.ESC)H")
    #endif
  }
  
  @Test("on macOS") func macOS() {
    #if os(macOS)
    #expect(ANSIEscapeCode.clearTerminal() == "\(ANSIEscapeCode.EraseScreen)\(ANSIEscapeCode.ESC)3J\(ANSIEscapeCode.ESC)H")
    #endif
  }
}
