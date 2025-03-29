import Testing
import AnsiEscapes

@Suite("Erases") struct EraseLines {
  @Test("one line and moves the cursor to the left") func one() {
    #expect(ANSIEscapeCode.eraseLines(count: 1) ==
            """
            \(ANSIEscapeCode.EraseLine)\
            \(ANSIEscapeCode.CursorLeft)
            """)
  }
  
  @Test("three lines and moves the cursor to the left") func three() {
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
  
  @Test("twelve lines and moves the cursor to the left") func twelve() {
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

@Test("Does not erase lines and move the cursor to the left", arguments: -100...0)
func doesNotEraseLines(_ count: Int) {
  #expect(ANSIEscapeCode.eraseLines(count: count) == "")
}
