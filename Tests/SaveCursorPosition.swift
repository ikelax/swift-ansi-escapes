import AnsiEscapes
import Testing

@Suite("Saves the cursor's position") struct SaveCursorPosition {
  @Test("in Apple's Terminal") func inAppleTerminal() {
    #expect(ANSIEscapeCode.saveCursorPosition(inTerminal: "Apple_Terminal") == "\u{001B}7")
  }

  @Test("in other terminals") func otherTerminals() {
    #expect(ANSIEscapeCode.saveCursorPosition(inTerminal: "iTerm2") == "\(ANSIEscapeCode.ESC)s")
  }
}
