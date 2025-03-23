import Testing
import AnsiEscapes

@Suite("Moves the cursor to") struct MoveCursorTo {
  @Test("(1, 3) for (1, 3)") func moveCursorTo1And3() {
    #expect(moveCursorTo(x: 1, y: 3) == "\(ANSIEscapeCode.ESC)4\(ANSIEscapeCode.SEP)2H")
  }

  @Test("(40, 678) for (40, 678)") func moveCursorTo40And678() {
    #expect(moveCursorTo(x: 40, y: 678) == "\(ANSIEscapeCode.ESC)679\(ANSIEscapeCode.SEP)41H")
  }

  @Test("(0, 0) for (0, 0)") func moveCursorTo0And0() {
    #expect(moveCursorTo(x: 0, y: 0) == "\(ANSIEscapeCode.ESC)1\(ANSIEscapeCode.SEP)1H")
  }

  @Test("(0, 1) for (0, 1)") func moveCursorTo0And1() {
    #expect(moveCursorTo(x: 0, y: 1) == "\(ANSIEscapeCode.ESC)2\(ANSIEscapeCode.SEP)1H")
  }

  @Test("(0, 1) for x = 0") func moveCursorTo0And1OnlyX() {
    #expect(moveCursorTo(x: 0) == "\(ANSIEscapeCode.ESC)1G")
  }

  @Test("(23, 1) for x = 23") func moveCursorTo23And1OnlyX() {
    #expect(moveCursorTo(x: 23) == "\(ANSIEscapeCode.ESC)24G")
  }
}
