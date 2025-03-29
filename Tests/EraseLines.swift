import Testing
import AnsiEscapes

@Suite("Moves the cursor to the left after erasing") struct EraseLines {
  @Test("one line") func one() {
    #expect(ANSIEscapeCode.eraseLines(count: 1) ==
            """
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.CursorLeft)
            """)
  }
  
  @Test("three lines") func three() {
    #expect(ANSIEscapeCode.eraseLines(count: 3) ==
            """
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.CursorLeft)
            """)
  }
  
  @Test("twelve lines") func twelve() {
    #expect(ANSIEscapeCode.eraseLines(count: 12) ==
            """
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.moveCursorUp())\
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.CursorLeft)
            """)
  }
}

@Test("Does not erase lines and does not move the cursor to the left", arguments: -100...0)
func doesNotEraseLines(_ count: Int) {
  #expect(ANSIEscapeCode.eraseLines(count: count) == "")
}
