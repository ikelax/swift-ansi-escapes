import Testing
import AnsiEscapes

@Suite("Moves the cursor") struct MoveCursorRelativeBy {
  @Suite("on x-axis relative by") struct OnXAxis {
    @Test("(0, 0)") func moveCursorRelativeBy0and0() {
      #expect(moveCursorRelativeBy(x: 0, y: 0) == "\(ANSIEscapeCode.ESC)0B")
    }
    
    @Test("(0, 1)") func moveCursorRelativeBy0and1() {
      #expect(moveCursorRelativeBy(x: 0, y: 1) == "\(ANSIEscapeCode.ESC)1B")
    }
    
    @Test("(0, 82)") func moveCursorRelativeBy0and82() {
      #expect(moveCursorRelativeBy(x: 0, y: 82) == "\(ANSIEscapeCode.ESC)82B")
    }
    
    @Test("(0, -1)") func moveCursorRelativeBy0andMinus1() {
      #expect(moveCursorRelativeBy(x: 0, y: -1) == "\(ANSIEscapeCode.ESC)1A")
    }
    
    @Test("(0, -9000)") func moveCursorRelativeBy0andMinus9000() {
      #expect(moveCursorRelativeBy(x: 0, y: -9000) == "\(ANSIEscapeCode.ESC)9000A")
    }
    
    @Test("x = 0") func moveCursorRelativeBy0() {
      #expect(moveCursorRelativeBy(x: 0) == "")
    }
  }
  
  @Suite("above x-axis relative by") struct AboveXAxis {
    @Test("(1, 0)") func moveCursorRelativeBy1and0() {
      #expect(moveCursorRelativeBy(x: 1, y: 0) == "\(ANSIEscapeCode.ESC)1C\(ANSIEscapeCode.ESC)0B")
    }
    
    @Test("(1, 1)") func moveCursorRelativeBy1and1() {
      #expect(moveCursorRelativeBy(x: 1, y: 1) == "\(ANSIEscapeCode.ESC)1C\(ANSIEscapeCode.ESC)1B")
    }
    
    @Test("(1, 19)") func moveCursorRelativeBy1and19() {
      #expect(moveCursorRelativeBy(x: 1, y: 19) == "\(ANSIEscapeCode.ESC)1C\(ANSIEscapeCode.ESC)19B")
    }
    
    @Test("(1, -1)") func moveCursorRelativeBy1andMinus1() {
      #expect(moveCursorRelativeBy(x: 1, y: -1) == "\(ANSIEscapeCode.ESC)1C\(ANSIEscapeCode.ESC)1A")
    }
    
    @Test("(1, -7)") func moveCursorRelativeBy1andMinus7() {
      #expect(moveCursorRelativeBy(x: 1, y: -7) == "\(ANSIEscapeCode.ESC)1C\(ANSIEscapeCode.ESC)7A")
    }
    
    @Test("x = 1") func moveCursorRelativeBy1() {
      #expect(moveCursorRelativeBy(x: 1) == "\(ANSIEscapeCode.ESC)1C")
    }
    
    @Test("(3, 0)") func moveCursorRelativeBy3and0() {
      #expect(moveCursorRelativeBy(x: 3, y: 0) == "\(ANSIEscapeCode.ESC)3C\(ANSIEscapeCode.ESC)0B")
    }
    
    @Test("(20, 1)") func moveCursorRelativeBy20and1() {
      #expect(moveCursorRelativeBy(x: 20, y: 1) == "\(ANSIEscapeCode.ESC)20C\(ANSIEscapeCode.ESC)1B")
    }
    
    @Test("(4, 23)") func moveCursorRelativeBy4and23() {
      #expect(moveCursorRelativeBy(x: 4, y: 23) == "\(ANSIEscapeCode.ESC)4C\(ANSIEscapeCode.ESC)23B")
    }
    
    @Test("(42, -1)") func moveCursorRelativeBy42andMinus1() {
      #expect(moveCursorRelativeBy(x: 42, y: -1) == "\(ANSIEscapeCode.ESC)42C\(ANSIEscapeCode.ESC)1A")
    }
    
    @Test("(193, -81)") func moveCursorRelativeBy193andMinus81() {
      #expect(moveCursorRelativeBy(x: 193, y: -81) == "\(ANSIEscapeCode.ESC)193C\(ANSIEscapeCode.ESC)81A")
    }
    
    @Test("x = 50") func moveCursorRelativeBy50() {
      #expect(moveCursorRelativeBy(x: 50) == "\(ANSIEscapeCode.ESC)50C")
    }
  }
  
  @Suite("on x-axis relative by") struct BelowXAxis {
    @Test("(-1, 0)") func moveCursorRelativeByMinus1and0() {
      #expect(moveCursorRelativeBy(x: -1, y: 0) == "\(ANSIEscapeCode.ESC)1D\(ANSIEscapeCode.ESC)0B")
    }
    
    @Test("(-1, 1)") func moveCursorRelativeByMinus1and1() {
      #expect(moveCursorRelativeBy(x: -1, y: 1) == "\(ANSIEscapeCode.ESC)1D\(ANSIEscapeCode.ESC)1B")
    }
    
    @Test("(-1, 8)") func moveCursorRelativeByMinus1and8() {
      #expect(moveCursorRelativeBy(x: -1, y: 8) == "\(ANSIEscapeCode.ESC)1D\(ANSIEscapeCode.ESC)8B")
    }
    
    @Test("(-1, -1)") func moveCursorRelativeByMinus1andMinus1() {
      #expect(moveCursorRelativeBy(x: -1, y: -1) == "\(ANSIEscapeCode.ESC)1D\(ANSIEscapeCode.ESC)1A")
    }
    
    @Test("(-1, -98)") func moveCursorRelativeByMinus1andMinus98() {
      #expect(moveCursorRelativeBy(x: -1, y: -98) == "\(ANSIEscapeCode.ESC)1D\(ANSIEscapeCode.ESC)98A")
    }
    
    @Test("x = -1") func moveCursorRelativeByMinus1() {
      #expect(moveCursorRelativeBy(x: -1) == "\(ANSIEscapeCode.ESC)1D")
    }
    
    @Test("(-6, 0)") func moveCursorRelativeByMinus6and0() {
      #expect(moveCursorRelativeBy(x: -6, y: 0) == "\(ANSIEscapeCode.ESC)6D\(ANSIEscapeCode.ESC)0B")
    }
    
    @Test("(-66, 1)") func moveCursorRelativeByMinus66and1() {
      #expect(moveCursorRelativeBy(x: -66, y: 1) == "\(ANSIEscapeCode.ESC)66D\(ANSIEscapeCode.ESC)1B")
    }
    
    @Test("(-2, 34)") func moveCursorRelativeByMinus2and34() {
      #expect(moveCursorRelativeBy(x: -2, y: 34) == "\(ANSIEscapeCode.ESC)2D\(ANSIEscapeCode.ESC)34B")
    }
    
    @Test("(-18, -1)") func moveCursorRelativeByMinus18andMinus1() {
      #expect(moveCursorRelativeBy(x: -18, y: -1) == "\(ANSIEscapeCode.ESC)18D\(ANSIEscapeCode.ESC)1A")
    }
    
    @Test("(-777, -13)") func moveCursorRelativeByMinus777andMinus13() {
      #expect(moveCursorRelativeBy(x: -777, y: -13) == "\(ANSIEscapeCode.ESC)777D\(ANSIEscapeCode.ESC)13A")
    }
    
    @Test("x = -3") func moveCursorRelativeByMinus3() {
      #expect(moveCursorRelativeBy(x: -3) == "\(ANSIEscapeCode.ESC)3D")
    }
  }
}
