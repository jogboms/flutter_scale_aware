class ScreenConfig {
  const ScreenConfig({
    this.width = 1080,
    this.height = 1920,
    this.allowFontScaling = false,
  });

  /// Width of reference device. Defaults to 1080px
  final double width;

  /// Height of reference device. Defaults to 1920px
  final double height;

  /// Should allow automatic scaling of font sizes. Defaults to false
  final bool allowFontScaling;
}
