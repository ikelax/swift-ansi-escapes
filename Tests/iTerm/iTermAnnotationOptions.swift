import Testing
@testable import AnsiEscapes

let testCasesInitWithIsHidden = [
  (nil, nil, nil, false),
  (nil, nil, nil, true),
  (nil, nil, 7, false),
  (nil, nil, 2, true),
  (2, 3, 4, false),
  (19, 200, 2101, true),
]

typealias OptionsWithIsHidden = (x: Int?, y: Int?, length: Int?, isHidden: Bool)

let testCasesThrowsWithIsHidden: [OptionsWithIsHidden] = [
  (0, nil, nil, false),
  (27, nil, nil, true),
  (39, 8, nil, false),
  (845, 29, nil, true),
  (88, nil, 20, false),
  (11, nil, 4, true),
  (nil, 349, nil, false),
  (nil, 5, nil, true),
  (494, 6, nil, false),
  (3494, 4959, nil, true),
  (nil, 92, 19, false),
  (nil, 0, 0, true),
  (33, nil, 7, false),
  (34, nil, 6, true),
  (nil, 23, 1, false),
  (nil, 1, 0, true),
]

@Suite("If isHidden is defined") struct InitWithIsHidden {
  @Suite("it initializes the annotation options") struct InitSuccessfully {
    @Test("", arguments: testCasesInitWithIsHidden)
    func initWithIsHidden(_ options: OptionsWithIsHidden) {
      #expect(throws: Never.self) {
        try iTermAnnotationOptions(x: options.x, y: options.y, length: options.length, isHidden: options.isHidden)
      }
    }
    
    @Test("with isHidden set to the passed argument", arguments: testCasesInitWithIsHidden)
    func isHiddenSetToArgument(_ options: OptionsWithIsHidden) {
      #expect(try! iTermAnnotationOptions(x: options.x, y: options.y, length: options.length, isHidden: options.isHidden).isHidden == options.isHidden)
    }
  }
  
  @Test("it throws when x or y is defined but not all of x, y and length are defined",
        arguments: testCasesThrowsWithIsHidden)
  func initThrows(_ options: OptionsWithIsHidden) {
    #expect(
      throws: iTermAnnotationError.invalidOptions(
        "`x`, `y` and `length` must be defined when `x` or `y` is defined"
      )
    ) {
      try iTermAnnotationOptions(x: options.x, y: options.y, length: options.length, isHidden: options.isHidden)
    }
  }
}

let testCasesInitWithoutIsHidden = [
  (nil, nil, nil),
  (nil, nil, 4),
  (96, 5, 6576),
]

typealias OptionsWithoutIsHidden = (x: Int?, y: Int?, length: Int?)

let testCasesThrowsWithoutIsHidden: [OptionsWithoutIsHidden] = [
  (2, nil, nil),
  (2, 65, nil),
  (2, nil, 49),
  (nil, 812, nil),
  (7, 812, nil),
  (nil, 812, 44),
  (0, nil, 71),
  (nil, 1, 71),
]

@Suite("If isHidden is not defined") struct InitWithoutIsHidden {
  @Suite("it initializes the annotation options") struct InitSuccessfully {
    @Test("", arguments: testCasesInitWithoutIsHidden)
    func initWithoutIsHidden(_ options: OptionsWithoutIsHidden) {
      #expect(throws: Never.self) {
        try iTermAnnotationOptions(x: options.x, y: options.y, length: options.length)
      }
    }
    
    @Test("with isHidden = false by default", arguments: testCasesInitWithoutIsHidden)
    func isHiddenHasDefaultFalse(_ options: OptionsWithoutIsHidden) {
      #expect(try! iTermAnnotationOptions(x: options.x, y: options.y, length: options.length).isHidden == false)
    }
  }
  
  @Test("it throws when x or y is defined but not all of x, y and length are defined",
        arguments: testCasesThrowsWithoutIsHidden)
  func initThrows(_ options: OptionsWithoutIsHidden) {
    #expect(
      throws: iTermAnnotationError.invalidOptions(
        "`x`, `y` and `length` must be defined when `x` or `y` is defined"
      )
    ) {
      try iTermAnnotationOptions(x: options.x, y: options.y, length: options.length)
    }
  }
}
