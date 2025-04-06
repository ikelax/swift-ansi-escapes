import AnsiEscapes
import Testing

@Suite("Restores the saved cursor position") struct RestoreCursorPosition {
  @Test("in Apple's Terminal") func inAppleTerminal() {
    #expect(ANSIEscapeCode.restoreCursorPosition(inTerminal: "Apple_Terminal") == "\u{001B}8")
  }

  @Test("in other terminals") func otherTerminals() {
    #expect(ANSIEscapeCode.restoreCursorPosition(inTerminal: "iTerm2") == "\(ANSIEscapeCode.ESC)u")
  }
}
