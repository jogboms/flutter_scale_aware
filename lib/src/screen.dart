import 'dart:math';

import 'package:flutter/foundation.dart' show required;
import 'package:flutter/rendering.dart' show Size;

import 'screen_config.dart';

class Screen {
  factory Screen() => _instance;

  factory Screen.create({
    @required Size size,
    @required double pixelRatio,
    @required double textScaleFactor,
    ScreenConfig config = const ScreenConfig(),
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

  Screen._({this.size, this.pixelRatio, this.textScaleFactor, this.config})
      : _widthRatio = size.width / config.width,
        _heightRatio = size.height / config.height;

  final Size size;
  final double pixelRatio;
  final double textScaleFactor;
  final ScreenConfig config;

  static Screen _instance;
  final double _widthRatio;
  final double _heightRatio;

  double vh(num height) => height * _heightRatio * pixelRatio;
  double vw(num width) => width * _widthRatio * pixelRatio;
  double dp(num dimension) => min(vw(dimension), vh(dimension));
  double sp(num fontSize) => config.allowFontScaling ? vw(fontSize) : vw(fontSize) / textScaleFactor;

  @override
  String toString() => '$runtimeType('
      'textScaleFactor: $textScaleFactor, '
      'pixelRatio: $pixelRatio, '
      'width: ${size.width}, '
      'height: ${size.height}'
      ')';
}
