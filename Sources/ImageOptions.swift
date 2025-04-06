/// The options for the [image display feature](https://iterm2.com/documentation-images.html) in iTerm2.
/// Currently, not the whole feature is supported.
public struct ImageOptions: Sendable {
  /// Height to render in character cells.
  let height: Int
  /// Width to render in character cells.
  let width: Int
  /// If set to `false`, then the image's inherent aspect ratio will not be respected.
  /// Otherwise, it will fill the specified `width` and `height` as much as possible without stretching.
  let preserveAspectRatio: Bool

  public init(height: Int, width: Int, preserveAspectRatio: Bool) {
    self.height = height
    self.width = width
    self.preserveAspectRatio = preserveAspectRatio
  }
}
