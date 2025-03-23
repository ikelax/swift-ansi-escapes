extension ANSIEscapeCode {
  
  /// iTerm supports proprietary escape codes. You can read more about them
  /// in the [iTerm documentation](https://iterm2.com/documentation-escape-codes.html).
  public struct iTerm {
    private init() {}
    
    /// Inform iTerm2 of the current directory to help semantic history.
    /// - Parameter dir: The current directory to inform to iTerm2.
    /// - Returns: The ANSI escape code.
    public static func informCurrentDir(_ dir: String) -> String {
      "\(ANSIEscapeCode.OSC)1337;CurrentDir=\(dir)\(ANSIEscapeCode.BEL)"
    }
    
    public func annotation(message: String, options: iTermAnnotationOptions) -> String {
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
