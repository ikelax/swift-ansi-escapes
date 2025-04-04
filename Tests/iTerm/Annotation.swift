import AnsiEscapes
import Testing

// | is disallowed and therefore stripped.
private let testCases = [
  // isHidden: false
  (
    "", try! iTermAnnotationOptions(),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=\(ANSIEscapeCode.BEL)"
  ),
  (
    "|", try! iTermAnnotationOptions(),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=\(ANSIEscapeCode.BEL)"
  ),
  (
    "Hello world!", try! iTermAnnotationOptions(),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=Hello world!\(ANSIEscapeCode.BEL)"
  ),
  (
    "Hello|'|world:", try! iTermAnnotationOptions(),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=Hello'world:\(ANSIEscapeCode.BEL)"
  ),

  // isHidden: true
  (
    "", try! iTermAnnotationOptions(isHidden: true),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=\(ANSIEscapeCode.BEL)"
  ),
  (
    "||||", try! iTermAnnotationOptions(isHidden: true),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=\(ANSIEscapeCode.BEL)"
  ),
  (
    ".H.i,", try! iTermAnnotationOptions(isHidden: true),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=.H.i,\(ANSIEscapeCode.BEL)"
  ),
  (
    ".H|i,", try! iTermAnnotationOptions(isHidden: true),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=.Hi,\(ANSIEscapeCode.BEL)"
  ),

  // length: k, isHidden: false
  (
    "", try! iTermAnnotationOptions(length: 10),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=10|\(ANSIEscapeCode.BEL)"
  ),
  (
    "||", try! iTermAnnotationOptions(length: 1),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=1|\(ANSIEscapeCode.BEL)"
  ),
  (
    "message", try! iTermAnnotationOptions(length: 392),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=392|message\(ANSIEscapeCode.BEL)"
  ),
  (
    "|message|", try! iTermAnnotationOptions(length: 4),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=4|message\(ANSIEscapeCode.BEL)"
  ),

  // length: k, isHidden: true
  (
    "", try! iTermAnnotationOptions(length: 3, isHidden: true),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=3|\(ANSIEscapeCode.BEL)"
  ),
  (
    "|||||||", try! iTermAnnotationOptions(length: 42, isHidden: true),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=42|\(ANSIEscapeCode.BEL)"
  ),
  (
    "N0ti*ciaS", try! iTermAnnotationOptions(length: 7, isHidden: true),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=7|N0ti*ciaS\(ANSIEscapeCode.BEL)"
  ),
  (
    "|n|o|t|i|c|i|a|s", try! iTermAnnotationOptions(length: 5, isHidden: true),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=5|noticias\(ANSIEscapeCode.BEL)"
  ),

  // x: i, y: j, length: k, isHidden: false
  (
    "", try! iTermAnnotationOptions(x: 1, y: 2, length: 3),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=|3|1|2\(ANSIEscapeCode.BEL)"
  ),
  (
    "|", try! iTermAnnotationOptions(x: 17, y: 19, length: 23),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=|23|17|19\(ANSIEscapeCode.BEL)"
  ),
  (
    "tin nhắn", try! iTermAnnotationOptions(x: 0, y: 0, length: 8),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=tin nhắn|8|0|0\(ANSIEscapeCode.BEL)"
  ),
  (
    "tin||nhắn |:)|", try! iTermAnnotationOptions(x: 1, y: 0, length: 1200),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=tinnhắn :)|1200|1|0\(ANSIEscapeCode.BEL)"
  ),

  // x: i, y: j, length: k, isHidden: true
  (
    "", try! iTermAnnotationOptions(x: 0, y: 1, length: 2, isHidden: true),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=|2|0|1\(ANSIEscapeCode.BEL)"
  ),
  (
    "| |", try! iTermAnnotationOptions(x: 5, y: 15, length: 25, isHidden: true),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation= |25|5|15\(ANSIEscapeCode.BEL)"
  ),
  (
    "(nachricht)", try! iTermAnnotationOptions(x: 100, y: 1000, length: 10_000, isHidden: true),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=(nachricht)|10000|100|1000\(ANSIEscapeCode.BEL)"
  ),
  (
    "nach | richt", try! iTermAnnotationOptions(x: 64, y: 32, length: 16, isHidden: true),
    "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=nach  richt|16|64|32\(ANSIEscapeCode.BEL)"
  ),
]

@Test("It should generate the correct escape code for annotations: ", arguments: testCases)
func annotationTest(
  _ test: (message: String, iTermAnnotationOptions: iTermAnnotationOptions, escapeCode: String)
) {
  #expect(
    ANSIEscapeCode.iTerm.annotation(message: test.message, options: test.iTermAnnotationOptions)
      == test.escapeCode)
}
