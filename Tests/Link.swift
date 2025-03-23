import Testing
import AnsiEscapes

@Test("Creates a clickable link") func createsClickableLink() {
  #expect(
    ANSIEscapeCode.link(withText: "Link", andUrl: "https://github.com/ikelax/swift-ansi-escapes")
    == "\u{001B}]8;;https://github.com/ikelax/swift-ansi-escapes\u{0007}Link\u{001B}]8;;\u{0007}"
  )
}
