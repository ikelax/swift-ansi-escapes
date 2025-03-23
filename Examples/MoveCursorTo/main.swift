import AnsiEscapes

// We want to print
//
// 0
//  1
//   2
//    3
//     4
//      5
//       6
//        7
//         8
//          9

print(clearTerminal())

for i in 0..<10 {
  print(moveCursorTo(x: i, y: i), terminator: "")
  print(String(i), terminator: "")
}
