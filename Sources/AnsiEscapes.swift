import Foundation

public struct ANSIEscapeCode {
  public static let ESC = "\u{001B}["
  public static let OSC = "\u{001B}]"
  public static let BEL = "\u{0007}"
  public static let SEP = ";"
  
  /// Erases from the current cursor position to the start of the current line.
  public static let EraseStartLine = ESC + "1K"
  /// Erases from the current cursor position to the end of the current line.
  public static let EraseEndLine = ESC + "0K"
  /// Erases the entire current line.
  public static let EraseLine = ESC + "2K"
  /// Erases the screen from the current line down to the bottom of the screen.
  public static let EraseDown = ESC + "J"
  /// Erases the screen from the current line up to the top of the screen.
  public static let EraseUp = ESC + "1J"
  /// Erases the screen and moves the cursor to the top left position.
  public static let EraseScreen = ESC + "2J"
  
  /// Scrolls the display up by one line.
  public static let ScrollUp = ESC + "S"
  /// Scrolls the display down by one line.
  public static let ScrollDown = ESC + "T"
  
  /// Get the cursor's position.
  public static let CursorGetPosition = ESC + "6n"
  /// Moves the cursor to the left side.
  public static let CursorLeft = ESC + "G"
  /// Moves the cursor to the next line.
  public static let CursorNextLine = ESC + "E"
  /// Moves the cursor to the previous line.
  public static let CursorPrevLine = ESC + "F"
  /// Shows the cursor.
  public static let CursorShow = ESC + "?25h"
  /// Hides the cursor.
  public static let CursorHide = ESC + "?25l"
  
  /// Enters the [alternative screen](https://terminalguide.namepad.de/mode/p47/).
  public static let EnterAlternativeScreen = ESC + "?1049h"
  /// Exits the [alternative screen](https://terminalguide.namepad.de/mode/p47/), assuming `EnterAlternativeScreen` was called before.
  public static let ExitAlternativeScreen = ESC + "?1049l"
  
  /// Outputs a beeping sound.
  public static let Beep = BEL
  
  /// Clears the terminal screen.
  public static let ClearScreen = "\u{001B}c"
  
  /// Saves the cursor's position.
  /// - Parameter terminal: The terminal for which the escape code is. Defaults to the environment variable `TERM_PROGRAM`.
  /// - Returns: The ANSI escape code.
  public static func saveCursorPosition(inTerminal terminal: String? = ProcessInfo.processInfo.environment["TERM_PROGRAM"]) -> String {
    if terminal == "Apple_Terminal" {
      "\u{001B}7"
    } else {
      "\(ANSIEscapeCode.ESC)s"
    }
  }
  
  /// Restores the saved cursor position.
  /// - Parameter terminal: The terminal for which the escape code is. Defaults to the environment variable `TERM_PROGRAM`.
  /// - Returns: The ANSI escape code.
  public static func restoreCursorPosition(inTerminal terminal: String? = ProcessInfo.processInfo.environment["TERM_PROGRAM"]) -> String {
    if terminal == "Apple_Terminal" {
      "\u{001B}8"
    } else {
      "\(ANSIEscapeCode.ESC)u"
    }
  }
  
  private init() {}
  
  /// Clears the whole terminal, including scrollback buffer. It does not clear just the visible part of it.
  /// - Parameters:
  ///   - onWindows: Whether the escape code is for Windows. Defaults to `false`.
  /// - Returns: The ANSI escape code.
  public static func clearTerminal(onWindows: Bool = false) -> String {
    if (onWindows) {
      "\(ANSIEscapeCode.EraseScreen)\(ANSIEscapeCode.ESC)0f"
    } else {
      // 1. Erases the screen (Only done in case `2` is not supported)
      // 2. Erases the whole screen including scrollback buffer
      // 3. Moves cursor to the top-left position
      // More info: https://www.real-world-systems.com/docs/ANSIcode.html
      "\(ANSIEscapeCode.EraseScreen)\(ANSIEscapeCode.ESC)3J\(ANSIEscapeCode.ESC)H"
    }
  }
  
  /// Sets the absolute position of the cursor. `x = 0` and `y = 0` is the top left of the terminal screen. Negative integers are treated as `0`.
  /// - Parameters:
  ///   - x: The horizontal position of the cursor from left to right.
  ///   - y: The vertical position of the cursor from top to bottom. If `y` is `nil`, it is set to `1`.
  /// - Returns: The ANSI escape code.
  public static func moveCursorTo(x: Int, y: Int? = nil) -> String {
    if let y = y {
      return "\(ANSIEscapeCode.ESC)\(y + 1)\(ANSIEscapeCode.SEP)\(x + 1)H"
    }
    
    return "\(ANSIEscapeCode.ESC)\(x + 1)G"
  }

  /// Sets the position of the cursor relative to its current position.
  /// - Parameters:
  ///   - x: The number of rows the cursor is moved forward (positive) or backward (negative).
  ///   - y: The number of lines the cursor is moved up (negative) or down (positive).
  /// - Returns: The ANSI ecape code.
  public static func moveCursorRelativeBy(x: Int, y: Int? = nil) -> String {
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
  /// - Parameter y: The number of rows the cursor is moved up. Default is `1`.
  /// - Returns: The ANSI escape code.
  public static func moveCursorUp(for y: Int = 1) -> String {
    "\(ANSIEscapeCode.ESC)\(y)A"
  }

  /// Moves the cursor down a specific amount of rows.
  /// - Parameter y: The number of rows the cursor is moved down. Default is `1`.
  /// - Returns: The ANSI escape code.
  public static func moveCursorDown(for y: Int = 1) -> String {
    "\(ANSIEscapeCode.ESC)\(y)B"
  }

  /// Moves the cursor forward a specific amount of columns.
  /// - Parameter x: The number of columns the cursor is moved forward. Default is `1`.
  /// - Returns: The ANSI escape code.
  public static func moveCursorForward(for x: Int = 1) -> String {
    "\(ANSIEscapeCode.ESC)\(x)C"
  }

  /// Moves the cursor backward a specific amount of columns.
  /// - Parameter x: The number of columns the cursor is moved backward. Default is `1`.
  /// - Returns: The ANSI escape code.
  public static func moveCursorBackward(for x: Int = 1) -> String {
    "\(ANSIEscapeCode.ESC)\(x)D"
  }
  
  /// Creates a clickable link. For supported terminals see
  /// [1](https://emnudge.dev/notes/terminal-links/) and
  /// [2](https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda).
  /// - Parameters:
  ///   - text: The text of the link
  ///   - url: The URL of the link
  /// - Returns: The ANSI escape code.
  public static func link(withText text: String, andUrl url: String) -> String {
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
}

public func eraseLines(count: Int) -> String {
  var escapeCode = ""
  
  for i in 0..<count {
    escapeCode += ANSIEscapeCode.EraseLine + (i < count - 1 ? ANSIEscapeCode.moveCursorUp() : "")
  }
  
  if count != 0 {
    escapeCode += ANSIEscapeCode.CursorLeft
  }
  
  return escapeCode
}

public struct ImageOptions {
  let height: Int
  let width: Int
  let preverseAspectRatio: Bool
}
