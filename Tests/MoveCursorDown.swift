import AnsiEscapes
import Testing

@Suite("Moves the cursor down by") struct MoveCursorDown {
  @Test("1 by default") func moveCursorDownDefault() {
    #expect(ANSIEscapeCode.moveCursorDown() == "\(ANSIEscapeCode.ESC)1B")
  }

  @Test("4") func moveCursorDownBy4() {
    #expect(ANSIEscapeCode.moveCursorDown(for: 4) == "\(ANSIEscapeCode.ESC)4B")
  }

  @Test("1806") func moveCursorDownBy1806() {
    #expect(ANSIEscapeCode.moveCursorDown(for: 1806) == "\(ANSIEscapeCode.ESC)1806B")
  }
}
