import Testing
import AnsiEscapes

@Suite("Moves the cursor up by") struct MoveCursorUp {
  @Test("1 by default") func moveCursorUpDefault() {
    #expect(ANSIEscapeCode.moveCursorUp() == "\(ANSIEscapeCode.ESC)1A")
  }
  
  @Test("7") func moveCursorUpBy7() {
    #expect(ANSIEscapeCode.moveCursorUp(for: 7) == "\(ANSIEscapeCode.ESC)7A")
  }
  
  @Test("834") func moveCursorUpBy834() {
    #expect(ANSIEscapeCode.moveCursorUp(for: 834) == "\(ANSIEscapeCode.ESC)834A")
  }
}
