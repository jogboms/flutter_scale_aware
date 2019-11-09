import 'dart:math' show min;

import 'package:flutter/foundation.dart' show required;
import 'package:flutter/rendering.dart' show Size;

import 'config.dart';

class Screen {
  /// Single-instance factory constructor
  factory Screen() {
    if (_instance == null) {
      throw Exception("You cannot use Screen() without first calling Screen.create or using ScreenAwareProvider");
    }
    return _instance;
  }

  factory Screen.create({
    @required Size size,
    @required double pixelRatio,
    @required double textScaleFactor,
    @required ScreenConfig config,
  }) {
    assert(size != null);
    assert(pixelRatio != null);
    assert(textScaleFactor != null);
    assert(config != null);
    return _instance = Screen._(
      size: size / pixelRatio,
      pixelRatio: pixelRatio,
      textScaleFactor: textScaleFactor,
      config: config,
    );
  }

  Screen._({this.size, this.pixelRatio, this.textScaleFactor, this.config});

  /// Physical size of the device
  final Size size;

  /// Pixel ratio of the device
  final double pixelRatio;

  /// Scale factor of font size on the device
  final double textScaleFactor;

  /// Screen configuration of reference device
  final ScreenConfig config;

  static Screen _instance;

  /// Relative to 1% of the height of the viewport (device window size). If the viewport is 800px high, 1vh = 8px.
  double vh(num height) => height * size.height / config.height;

  /// Relative to 1% of the width of the viewport (device window size). If the viewport is 500px wide, 1vw = 5px.
  double vw(num width) => width * size.width / config.width;

  /// Device-independent pixels. Where One pixel on a 160dpi screen, and equals two pixels for a 320dpi screen.
  double dp(num dimension) => dimension * size.shortestSide / min(config.width, config.height);

  /// Relative to the font-size setting of the actual device
  double sp(num fontSize) => config.allowFontScaling ? fontSize.toDouble() : fontSize / textScaleFactor;

  @override
  String toString() => '$runtimeType('
      'textScaleFactor: $textScaleFactor, '
      'pixelRatio: $pixelRatio, '
      'width: ${size.width}, '
      'height: ${size.height}'
      ')';
}
