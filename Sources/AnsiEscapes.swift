func isAppleTerminal() -> Bool {
  true
}

public enum ANSIEscapeCode {
  public static let ESC = "\u{001B}["
  public static let OSC = "\u{001B}]"
  public static let BEL = "\u{0007}"
  public static let SEP = ";"
  public static let EraseEndLine = ESC + "0K"
  public static let EraseStartLine = ESC + "1K"
  public static let EraseLine = ESC + "2K"
  public static let EraseDown = ESC + "J"
  public static let EraseUp = ESC + "1J"
  public static let EraseScreen = ESC + "2J"
  public static let ScrollUp = ESC + "S"
  public static let ScrollDown = ESC + "T"
  
  public static let CursorLeft = ESC + "G"
  
  public static let CursorGetPosition = ESC + "6n"
  public static let CursorNextLine = ESC + "E"
  public static let CursorPrevLine = ESC + "F"
  public static let CursorHide = ESC + "?25l"
  public static let CursorShow = ESC + "?25h"
  
  public static let EnterAlternativeScreen = ESC + "?1049h"
  public static let ExitAlternativeScreen = ESC + "?1049l"

  public static let Beep = BEL
  
  public static let ClearScreen = "\u{001B}c"
  
  public static let CursorSavePosition = isAppleTerminal() ? "\u{001B}7" : "\(ANSIEscapeCode.ESC)s"
  public static let CursorRestorePosition = isAppleTerminal() ? "\u{001B}8" : "\(ANSIEscapeCode.ESC)u"
}

/// Clear the whole terminal, including scrollback buffer. It does not clear just the visible part of it.
/// - Returns: The ANSI escape code.
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

/// Sets the absolute position of the cursor. `x = 0` and `y = 0` is the top left of the terminal screen. Negative integers are treated as `0`.
/// - Parameters:
///   - x: The horizontal position of the cursor from left to right.
///   - y: The vertical position of the cursor from top to bottom. If `y` is `nil`, it is set to `1`.
/// - Returns: The ANSI escape code.
public func moveCursorTo(x: Int, y: Int? = nil) -> String {
  if let y = y {
    return "\(ANSIEscapeCode.ESC)\(y + 1)\(ANSIEscapeCode.SEP)\(x + 1)H"
  }
  
  return "\(ANSIEscapeCode.ESC)\(x + 1)G"
}

/// Sets the position of the cursor relative to its current position.
/// - Parameters:
///   - x: The number of rows to move the cursor forward (positive) or backward (negative).
///   - y: The number of lines to move the cursor up (negative) or down (positive).
/// - Returns: The ANSI ecape code.
public func moveCursorRelativeBy(x: Int, y: Int? = nil) -> String {
  var escapeCode = ""
  
  if x < 0 {
    escapeCode = "\(ANSIEscapeCode.ESC)\(-x)D"
  } else if x > 0 {
    escapeCode = "\(ANSIEscapeCode.ESC)\(x)C"
  }
  
  guard let y = y else {
    return escapeCode
  }
  
  if y < 0 {
    return escapeCode + "\(ANSIEscapeCode.ESC)\(-y)A"
  }
  
  return escapeCode + "\(ANSIEscapeCode.ESC)\(y)B"
}

/// Moves the cursor up a specific amount of rows.
/// - Parameter y: The number of rows to move the cursor up. Default is `1`.
/// - Returns: The ANSI escape code.
public func moveCursorUp(for y: Int = 1) -> String {
  "\(ANSIEscapeCode.ESC)\(y)A"
}

/// Moves the cursor down a specific amount of rows.
/// - Parameter y: The number of rows to move the cursor down. Default is `1`.
/// - Returns: The ANSI escape code.
public func moveCursorDown(for y: Int = 1) -> String {
  "\(ANSIEscapeCode.ESC)\(y)B"
}

/// Moves the cursor forward a specific amount of columns.
/// - Parameter x: The number of columns to move the cursor forward. Default is `1`.
/// - Returns: The ANSI escape code.
public func moveCursorForward(for x: Int = 1) -> String {
  "\(ANSIEscapeCode.ESC)\(x)C"
}

/// Moves the cursor backward a specific amount of columns.
/// - Parameter x: The number of columns to move the cursor backward. Default is `1`.
/// - Returns: The ANSI escape code.
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
  
  public init(x: Int? = nil, y: Int? = nil, length: Int? = nil, isHidden: Bool = false) throws {
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
