import AnsiEscapes

print(ANSIEscapeCode.clearTerminal())

// The image was taken from https://www.pexels.com/photo/people-along-narrow-alley-2181111/.
// For simplicity, it is assumed that the file is run from the root folder of the project.
print(ANSIEscapeCode.iTerm.image(path: "Examples/Image/image.webp")!)

// Because the aspect ratio is respected, the height of the image is not stretched.
// The large distance to the image below is because the character cells
// that would be filled are left empty.
print(
  ANSIEscapeCode.iTerm.image(
    path: "Examples/Image/image.webp",
    options: ImageOptions(height: 10, width: 10, preserveAspectRatio: true))!)

// The aspect ratio is not respected. Thus, the image is stretched to fill the
// specified height and width.
print(
  ANSIEscapeCode.iTerm.image(
    path: "Examples/Image/image.webp",
    options: ImageOptions(height: 10, width: 10, preserveAspectRatio: false))!)
