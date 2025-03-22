func isAppleTerminal() -> Bool {
  true
}

public enum ANSIEscapeCode {
  static let ESC = "\u{001B}["
  static let OSC = "\u{001B}]"
  static let BEL = "\u{0007}"
  static let SEP = ";"
  static let EraseEndLine = ESC + "K"
  static let EraseStartLine = ESC + "1K"
  static let EraseLine = ESC + "2K"
  static let EraseDown = ESC + "J"
  static let EraseUp = ESC + "1J"
  static let EraseScreen = ESC + "2J"
  static let ScrollUp = ESC + "S"
  static let ScrollDown = ESC + "T"
  
  static let CursorLeft = ESC + "G"
  
  static let CursorGetPosition = ESC + "6n"
  static let CursorNextLine = ESC + "E"
  static let CursorPrevLine = ESC + "F"
  static let CursorHide = ESC + "?25l"
  static let CursorShow = ESC + "?25h"
  
  static let EnterAlternativeScreen = ESC + "?1049h"
  static let ExitAlternativeScreen = ESC + "?1049l"

  static let Beep = BEL
  
  static let ClearScreen = "\u{001B}c"
  
  static let CursorSavePosition = isAppleTerminal() ? "\u{001B}7" : "\(ANSIEscapeCode.ESC)s"
  static let CursorRestorePosition = isAppleTerminal() ? "\u{001B}8" : "\(ANSIEscapeCode.ESC)u"
}

public func clearTerminal() -> String {
  #if os(Windows)
  "\(ANSIEscapeCodes.EraseScreen)\(ANSIEscapeCodes.ESC)0f"
  #else
  // 1. Erases the screen (Only done in case `2` is not supported)
  // 2. Erases the whole screen including scrollback buffer
  // 3. Moves cursor to the top-left position
  // More info: https://www.real-world-systems.com/docs/ANSIcode.html
  "\(ANSIEscapeCode.EraseScreen)\(ANSIEscapeCode.ESC)3J\(ANSIEscapeCode.ESC)H"
  #endif
}

public func moveCursorTo(x: Int, y: Int? = nil) -> String {
  if let y = y {
    return "\(ANSIEscapeCode.ESC)\(y + 1)\(ANSIEscapeCode.SEP)\(x + 1)H"
  }
  
  return "\(ANSIEscapeCode.ESC)\(x + 1)G"
}

public func moveCursorFor(x: Int, y: Int? = nil) -> String {
  var escapeCode = ""
  
  if x < 0 {
    escapeCode = "\(ANSIEscapeCode.ESC)\(-x)D"
  } else if x > 0 {
    escapeCode = "\(ANSIEscapeCode.ESC)\(x)C"
  }
  
  guard let y = y, y == 0 else {
    return escapeCode
  }
  
  if y < 0 {
    return escapeCode + "\(ANSIEscapeCode.ESC)\(-x)A"
  }
  
  return escapeCode + "\(ANSIEscapeCode.ESC)\(x)B"
}

public func moveCursorUp(for y: Int = 1) -> String {
  "\(ANSIEscapeCode.ESC)\(y)A"
}

public func moveCursorDown(for y: Int = 1) -> String {
  "\(ANSIEscapeCode.ESC)\(y)B"
}

public func moveCursorForward(for x: Int = 1) -> String {
  "\(ANSIEscapeCode.ESC)\(x)C"
}

public func moveCursorBackward(for x: Int = 1) -> String {
  "\(ANSIEscapeCode.ESC)\(x)D"
}

public func eraseLines(count: Int) -> String {
  var escapeCode = ""
  
  for i in 0..<count {
    escapeCode += ANSIEscapeCode.EraseLine + (i < count - 1 ? moveCursorUp() : "")
  }
  
  if count != 0 {
    escapeCode += ANSIEscapeCode.CursorLeft
  }
  
  return escapeCode
}

public func printLink(withText text: String, andUrl url: String) -> String {
  [
    ANSIEscapeCode.OSC,
    "8",
    ANSIEscapeCode.SEP,
    ANSIEscapeCode.SEP,
    url,
    ANSIEscapeCode.BEL,
    text,
    ANSIEscapeCode.OSC,
    "8",
    ANSIEscapeCode.SEP,
    ANSIEscapeCode.SEP,
    ANSIEscapeCode.BEL,
  ].joined(separator: "")
}

public struct ImageOptions {
  let height: Int
  let width: Int
  let preverseAspectRatio: Bool
}

public func printImage(data: String, options: ImageOptions?) -> String {
  var escapeCodePrefix = "\(ANSIEscapeCode.OSC)1337;File=inline=1"
  let escapeCodeForImage = ":\(ANSIEscapeCode.BEL)"
  
  guard let options = options else {
    return escapeCodePrefix + escapeCodeForImage
  }
  
  if options.width != 0 {
    escapeCodePrefix += ";width=\(options.width)"
  }
  
  if options.height != 0 {
    escapeCodePrefix += ";height=\(options.height)"
  }
  
  if !options.preverseAspectRatio {
    escapeCodePrefix += ";preserveAspectRatio=0"
  }
  
  return escapeCodePrefix + escapeCodeForImage
}

public func setCwdiTerm(cwd: String) -> String {
  "\(ANSIEscapeCode.OSC)50;CurrentDir=\(cwd)\(ANSIEscapeCode.BEL)"
}

public struct iTermAnnotationOptions {
  let length: Int?
  let x: Int?
  let y: Int?
  let isHidden: Bool
  
  enum AnnotationError: Error {
    case invalidOptions(String)
  }
  
  public func hasX() -> Bool { x != nil }
  
  init(x: Int? = nil, y: Int? = nil, length: Int? = nil, isHidden: Bool = false) throws {
    let hasX = x != nil
    let hasY = y != nil
    
    if (hasX || hasY) && !(hasX && hasY && length != nil) {
      throw AnnotationError.invalidOptions("`x`, `y` and `length` must be defined when `x` or `y` is defined")
    }
    
    self.length = length
    self.x = x
    self.y = y
    self.isHidden = isHidden
  }
}

public func annotationiTerm(message: String, options: iTermAnnotationOptions) -> String {
  let hiddenEscapeCode = options.isHidden ? "AddHiddenAnnotation=" : "AddAnnotation="
  var escapeCode = "\(ANSIEscapeCode.OSC)1337;\(hiddenEscapeCode)"
  
  var message = message
  message.replace("|", with: "")
  
  if options.length != 0 {
    if options.hasX() {
      escapeCode += "\(message)|\(options.length!)|\(options.x!)|\(options.y!)"
    } else {
      escapeCode += "\(options.length!)|\(message)"
    }
  } else {
    escapeCode += message
  }
  
  return escapeCode + ANSIEscapeCode.BEL
}
