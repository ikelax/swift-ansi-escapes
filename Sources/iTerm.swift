import Foundation

extension ANSIEscapeCode {
  
  /// iTerm2 supports proprietary escape codes. You can read more about them
  /// in the [iTerm2 documentation](https://iterm2.com/documentation-escape-codes.html).
  public struct iTerm {
    private init() {}
    
    /// Inform iTerm2 of the current directory to help semantic history.
    /// - Parameter dir: The current directory to inform to iTerm2.
    /// - Returns: The proprietary escape code supported by iTerm2.
    public static func setCurrentDir(_ dir: String) -> String {
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

    /// Displays an image in iTerm2.
    /// - Parameters:
    ///   - path: The image's path.
    ///   - options: Options for the image display escape code. See also ``ImageOptions``.
    /// - Returns: The proprietary escape code supported by iTerm2.
    public static func image(path: String, options: ImageOptions? = nil) -> String? {
      guard let image = try? Data(contentsOf: URL(filePath: path)) else {
        return nil
      }

      var escapeCodePrefix = "\(ANSIEscapeCode.OSC)1337;File=inline=1"
      let escapeCodeImage = ":\(image.base64EncodedString())\(ANSIEscapeCode.BEL)"

      guard let options = options else {
        return escapeCodePrefix + escapeCodeImage
      }

      if options.width > 0 {
        escapeCodePrefix += ";width=\(options.width)"
      }

      if options.height > 0 {
        escapeCodePrefix += ";height=\(options.height)"
      }

      if !options.preverseAspectRatio {
        escapeCodePrefix += ";preserveAspectRatio=0"
      }

      return escapeCodePrefix + escapeCodeImage
    }
  }

}
