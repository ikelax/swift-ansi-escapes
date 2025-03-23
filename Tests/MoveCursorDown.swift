import Testing
import AnsiEscapes

@Suite("Moves the cursor down by") struct MoveCursorDown {
  @Test("1 by default") func moveCursorDownDefault() {
    #expect(moveCursorDown() == "\(ANSIEscapeCode.ESC)1B")
  }
  
  @Test("4") func moveCursorDownBy4() {
    #expect(moveCursorDown(for: 4) == "\(ANSIEscapeCode.ESC)4B")
  }
  
  @Test("1806") func moveCursorDownBy1806() {
    #expect(moveCursorDown(for: 1806) == "\(ANSIEscapeCode.ESC)1806B")
  }
}
