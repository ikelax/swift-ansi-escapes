/// The options for the [annotation feature](https://iterm2.com/documentation-escape-codes.html) in iTerm.
/// Scroll in the documentation to Annotations.
public struct iTermAnnotationOptions {
  let length: Int?
  let x: Int?
  let y: Int?
  let isHidden: Bool
  
  func hasX() -> Bool { x != nil }
  
  /// `x`, `y` and `length` must be defined when `x` or `y` is defined.
  /// - Parameters:
  ///   - x: The starting x-coordinate for the annotation. Defaults to the cursor's x-coordinate.
  ///   - y: The starting y-coordinate for the annotation. Defaults to the cursor's y-coordinate.
  ///   - length: The number of cells to annotate. Defaults to the rest of the line beginning at the start of the annotation.
  ///   - isHidden: Hidden (`true`) does not reveal the annotation window at the time the escape sequence is received, while not hidden (`false`) opens it immediately.
  public init(x: Int? = nil, y: Int? = nil, length: Int? = nil, isHidden: Bool = false) throws {
    let hasX = x != nil
    let hasY = y != nil
    
    if (hasX || hasY) && !(hasX && hasY && length != nil) {
      throw iTermAnnotationError.invalidOptions("`x`, `y` and `length` must be defined when `x` or `y` is defined")
    }
    
    self.length = length
    self.x = x
    self.y = y
    self.isHidden = isHidden
  }
}

enum iTermAnnotationError: Error, Equatable {
  /// This error is thrown when `x` or `y` were defined but at least one of `x`, `y` and `length` in ``iTermAnnotationOptions`` where `nil`.
  case invalidOptions(String)
}
