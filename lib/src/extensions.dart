import 'package:flutter/widgets.dart';

import 'scale.dart';
import 'scale_aware.dart';

extension BuildContextExtensions on BuildContext {
  Scale get _scale {
    final data = MediaQuery.of(this);
    return Scale(size: data.size, textScaleFactor: data.textScaleFactor, config: ScaleAware.of(this));
  }

  /// Pixels scaled per device from design. Where One pixel on a 160px screen equals two pixels on a 320px screen.
  double scale(num width) => _scale.scale(width);

  /// Relative to the font-size setting of the actual device
  double fontScale(num fontSize) => _scale.fontScale(fontSize);
}
