/// The options for the [annotation feature](https://iterm2.com/documentation-escape-codes.html) in iTerm2.
/// Scroll in the documentation to Annotations.
public struct iTermAnnotationOptions: Sendable {
  let length: Int?
  let x: Int?
  let y: Int?
  let isHidden: Bool
  
  public func hasX() -> Bool { x != nil }
  
  /// `x`, `y` and `length` must be defined when `x` or `y` is defined.
  /// - Parameters:
  ///   - x: The starting x-coordinate for the annotation. Defaults to the cursor's x-coordinate.
  ///   - y: The starting y-coordinate for the annotation. Defaults to the cursor's y-coordinate.
  ///   - length: The number of cells to annotate. Defaults to the rest of the line beginning at the start of the annotation. `length` has to be positive.
  ///   - isHidden: Controls whether to open the annotation windows immediately. The annotation can be revealed by the command `Reveal Annotation` in the context menu.
  public init(x: Int? = nil, y: Int? = nil, length: Int? = nil, isHidden: Bool = false) throws {
    let hasX = x != nil
    let hasY = y != nil
    
    if let length = length {
      if length <= 0 {
        throw iTermAnnotationError.invalidLength
      }
    }
    
    if (hasX || hasY) && !(hasX && hasY && length != nil) {
      throw iTermAnnotationError.xOrYImpliesXYAndLength
    }
    
    self.length = length
    self.x = x
    self.y = y
    self.isHidden = isHidden
  }
}

enum iTermAnnotationError: Error, Equatable {
  /// `x`, `y` and `length` in ``iTermAnnotationOptions`` must be defined when `x` or `y` is defined'.
  case xOrYImpliesXYAndLength
  /// `length` in ``iTermAnnotationOptions`` must be positive. Otherwise, the annotation is not displayed.
  case invalidLength
}
