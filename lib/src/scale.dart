import 'dart:math';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/rendering.dart' show Size;
import 'package:flutter/widgets.dart';

import 'scale_config.dart';

class Scale {
  factory Scale({required Size size, required double textScaleFactor, required ScaleConfig config}) {
    if (_instance != null &&
        size == _instance!.size &&
        textScaleFactor == _instance!.textScaleFactor &&
        config == _instance!.config) {
      return _instance!;
    }
    return _instance = Scale._(size: size, textScaleFactor: textScaleFactor, config: config);
  }

  Scale._({required this.size, required this.textScaleFactor, required this.config});

  @visibleForTesting
  static void reset() => _instance = null;

  static Scale? _instance;

  /// Scale configuration of reference device
  final ScaleConfig config;

  /// Physical size of current device
  final Size size;

  /// Scale factor of font size on current device
  final double textScaleFactor;

  double get _widthScale => size.width / config.width;

  /// Pixels scaled per device from design. Where One pixel on a 160px screen equals two pixels on a 320px screen.
  /// Also and alias for scaleX
  double scale(num dimension) => dimension * _widthScale;

  double get _heightScale => size.height / config.height;

  /// Pixels scaled per device from design. Where One pixel on a 160px screen equals two pixels on a 320px screen.
  double scaleY(num dimension) => dimension * _heightScale;

  /// Relative to the font-size setting of the current device
  double fontScale(num fontSize) =>
      config.allowFontScaling ? (fontSize * min(_widthScale, _heightScale)) / textScaleFactor : fontSize.toDouble();

  @override
  String toString() => '$runtimeType('
      'textScaleFactor: $textScaleFactor, '
      'width: ${size.width}, '
      'height: ${size.height}'
      ')';
}
