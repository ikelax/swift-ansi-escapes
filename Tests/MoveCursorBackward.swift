import AnsiEscapes
import Testing

@Suite("Moves the cursor backward by") struct MoveCursorBackward {
  @Test("1 by default") func moveCursorBackwardDefault() {
    #expect(ANSIEscapeCode.moveCursorBackward() == "\(ANSIEscapeCode.ESC)1D")
  }

  @Test("0") func moveCursorBackwardBy0() {
    #expect(ANSIEscapeCode.moveCursorBackward(for: 0) == "\(ANSIEscapeCode.ESC)0D")
  }

  @Test("13") func moveCursorBackwardBy13() {
    #expect(ANSIEscapeCode.moveCursorBackward(for: 13) == "\(ANSIEscapeCode.ESC)13D")
  }
}
