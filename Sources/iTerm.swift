extension ANSIEscapeCode {
  
  /// iTerm2 supports proprietary escape codes. You can read more about them
  /// in the [iTerm2 documentation](https://iterm2.com/documentation-escape-codes.html).
  public struct iTerm {
    private init() {}
    
    /// Inform iTerm2 of the current directory to help semantic history.
    /// - Parameter dir: The current directory to inform to iTerm2.
    /// - Returns: The proprietary escape code supported by iTerm2.
    public static func informCurrentDir(_ dir: String) -> String {
      "\(ANSIEscapeCode.OSC)1337;CurrentDir=\(dir)\(ANSIEscapeCode.BEL)"
    }
    
    /// Adds an annotation displayed in iTerm2.
    /// - Parameters:
    ///   - message: The message to attach to the annotation. The `|` character is disallowed and will be stripped.
    ///   - options: Options for the annotation escape code. See also ``iTermAnnotationOptions``.
    /// - Returns: The proprietary escape code supported by iTerm2.
    public static func annotation(message: String, options: iTermAnnotationOptions) -> String {
      let hiddenEscapeCode = options.isHidden ? "AddHiddenAnnotation=" : "AddAnnotation="
      var escapeCode = "\(ANSIEscapeCode.OSC)1337;\(hiddenEscapeCode)"
      
      var message = message
      message.replace("|", with: "")
      
      if let length = options.length {
        if options.hasX() {
          escapeCode += "\(message)|\(length)|\(options.x!)|\(options.y!)"
        } else {
          escapeCode += "\(length)|\(message)"
        }
      } else {
        escapeCode += message
      }
      
      return escapeCode + ANSIEscapeCode.BEL
    }
    
    public func image(data: String, options: ImageOptions?) -> String {
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
  }

}
