import Testing
import AnsiEscapes

@Suite("Moves the cursor backward by") struct MoveCursorBackward {
  @Test("1 by default") func moveCursorBackwardDefault() {
    #expect(moveCursorBackward() == "\(ANSIEscapeCode.ESC)1C")
  }
  
  @Test("0") func moveCursorBackwardBy0() {
    #expect(moveCursorBackward(for: 0) == "\(ANSIEscapeCode.ESC)0C")
  }
  
  @Test("13") func moveCursorBackwardBy13() {
    #expect(moveCursorBackward(for: 13) == "\(ANSIEscapeCode.ESC)13C")
  }
}
