import Testing
import AnsiEscapes
import Foundation

private let path = "Tests/Fixtures/image.png"
private let base64 = "iVBORw0KGgoAAAANSUhEUgAAAAgAAAAIAQMAAAD+wSzIAAAABlBMVEX///+/v7+jQ3Y5AAAADklEQVQI12P4AIX8EAgALgAD/aNpbtEAAAAASUVORK5CYII="

private let escapeCodePrefix = "\(ANSIEscapeCode.OSC)1337;File=inline=1"
private let escapeCodeImage = ":\(base64)\(ANSIEscapeCode.BEL)"
private let escapeCodeWithoutOptions = escapeCodePrefix + escapeCodeImage

private let testCases: [(ImageOptions?, String)] = [
  
  (nil, escapeCodeWithoutOptions),
  
  // For non-positive widths and heights and
  // preserveAspectRatio = true nothing is added.
  (ImageOptions(height: -1, width: -100, preverseAspectRatio: true), escapeCodeWithoutOptions),
  (ImageOptions(height: 0, width: -5, preverseAspectRatio: true), escapeCodeWithoutOptions),
  (ImageOptions(height: -27, width: 0, preverseAspectRatio: true), escapeCodeWithoutOptions),
  
  // Whether the string for the parameter is added is a binary choice.
  // Since we have 3 parameters, there are 8 combinations.
  // The above tests cover the combination where all are not added.
  
  // Cases where height and width are added.
  (ImageOptions(height: 1, width: 1, preverseAspectRatio: true), "\(escapeCodePrefix);width=1;height=1\(escapeCodeImage)"),
  (ImageOptions(height: 88, width: 190190, preverseAspectRatio: false), "\(escapeCodePrefix);width=190190;height=88;preserveAspectRatio=0\(escapeCodeImage)"),
  
  // Cases where height is added and width is not added.
  (ImageOptions(height: 64, width: -256, preverseAspectRatio: true), "\(escapeCodePrefix);height=64\(escapeCodeImage)"),
  (ImageOptions(height: 1, width: -2, preverseAspectRatio: false), "\(escapeCodePrefix);height=1;preserveAspectRatio=0\(escapeCodeImage)"),
  
  // Cases where height is not added and width is added.
  (ImageOptions(height: -3, width: 4, preverseAspectRatio: true), "\(escapeCodePrefix);width=4\(escapeCodeImage)"),
  (ImageOptions(height: -801, width: 739443234, preverseAspectRatio: false), "\(escapeCodePrefix);width=739443234;preserveAspectRatio=0\(escapeCodeImage)"),
  
  // Cases where height and width are not added.
  (ImageOptions(height: -1, width: -1, preverseAspectRatio: false), "\(escapeCodePrefix);preserveAspectRatio=0\(escapeCodeImage)"),
]

@Test("It should generate the correct escape code for displaying an image with", arguments: testCases)
func imageTest(_ test: (imageOptions: ImageOptions?, escapeCode: String)) {
  #expect(ANSIEscapeCode.iTerm.image(path: path, options: test.imageOptions) == test.escapeCode)
}
