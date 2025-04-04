import AnsiEscapes
import Testing

@Suite("Moves the cursor forward by") struct MoveCursorForward {
  @Test("1 by default") func moveCursorForwardDefault() {
    #expect(ANSIEscapeCode.moveCursorForward() == "\(ANSIEscapeCode.ESC)1C")
  }

  @Test("2") func moveCursorForwardBy2() {
    #expect(ANSIEscapeCode.moveCursorForward(for: 2) == "\(ANSIEscapeCode.ESC)2C")
  }

  @Test("35") func moveCursorForwardBy35() {
    #expect(ANSIEscapeCode.moveCursorForward(for: 35) == "\(ANSIEscapeCode.ESC)35C")
  }
}
