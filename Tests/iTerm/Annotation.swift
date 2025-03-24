import Testing
import AnsiEscapes

// | is disallowed and therefore stripped.
let testCases = [
  // isHidden: false
  ("", try! iTermAnnotationOptions(), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=\(ANSIEscapeCode.BEL)"),
  ("|", try! iTermAnnotationOptions(), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=\(ANSIEscapeCode.BEL)"),
  ("Hello world!", try! iTermAnnotationOptions(), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=Hello world!\(ANSIEscapeCode.BEL)"),
  ("Hello|'|world:", try! iTermAnnotationOptions(), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=Hello'world:\(ANSIEscapeCode.BEL)"),
  
  // isHidden: true
  ("", try! iTermAnnotationOptions(isHidden: true), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=\(ANSIEscapeCode.BEL)"),
  ("||||", try! iTermAnnotationOptions(isHidden: true), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=\(ANSIEscapeCode.BEL)"),
  (".H.i,", try! iTermAnnotationOptions(isHidden: true), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=.H.i,\(ANSIEscapeCode.BEL)"),
  (".H|i,", try! iTermAnnotationOptions(isHidden: true), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=.Hi,\(ANSIEscapeCode.BEL)"),
  
  // length: k, isHidden: false
  ("", try! iTermAnnotationOptions(length: 10), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=10|\(ANSIEscapeCode.BEL)"),
  ("||", try! iTermAnnotationOptions(length: 1), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=1|\(ANSIEscapeCode.BEL)"),
  ("message", try! iTermAnnotationOptions(length: 392), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=392|message\(ANSIEscapeCode.BEL)"),
  ("|message|", try! iTermAnnotationOptions(length: 4), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddAnnotation=4|message\(ANSIEscapeCode.BEL)"),
  
  // length: k, isHidden: true
  ("", try! iTermAnnotationOptions(length: 3, isHidden: true), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=3|\(ANSIEscapeCode.BEL)"),
  ("|||||||", try! iTermAnnotationOptions(length: 42, isHidden: true), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=42|\(ANSIEscapeCode.BEL)"),
  ("N0ti*ciaS", try! iTermAnnotationOptions(length: 7, isHidden: true), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=7|N0ti*ciaS\(ANSIEscapeCode.BEL)"),
  ("|n|o|t|i|c|i|a|s", try! iTermAnnotationOptions(length: 5, isHidden: true), "\(ANSIEscapeCode.OSC)1337\(ANSIEscapeCode.SEP)AddHiddenAnnotation=5|noticias\(ANSIEscapeCode.BEL)"),
  
  // x: i, y: j, length: k, isHidden: false
  // ("", try! iTermAnnotationOptions(x: 1, y: 2, length: 10), ""),
  // ("", try! iTermAnnotationOptions(x: 3, y: 5, length: 10, isHidden: true), ""),
  
  // x: i, y: j, length: k, isHidden: true
]

@Test("It should generate the correct escape code for annotations: ", arguments: testCases)
func annotationTest(_ test: (message: String, iTermAnnotationOptions: iTermAnnotationOptions, escapeCode: String)) {
  #expect(ANSIEscapeCode.iTerm.annotation(message: test.message, options: test.iTermAnnotationOptions) == test.escapeCode)
}
