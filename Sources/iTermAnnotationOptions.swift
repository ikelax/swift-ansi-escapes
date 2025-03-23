public struct iTermAnnotationOptions {
  let length: Int?
  let x: Int?
  let y: Int?
  let isHidden: Bool
  
  func hasX() -> Bool { x != nil }
  
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

enum iTermAnnotationError: Error {
  case invalidOptions(String)
}
