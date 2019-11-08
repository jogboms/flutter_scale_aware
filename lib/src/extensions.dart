import 'screen.dart';

extension ScreenAwareExtensions<T extends num> on T {
  /// Device-independent pixels. Where One pixel on a 160dpi screen, and equals two pixels for a 320dpi screen.
  double get dp => Screen()?.dp(this) ?? toDouble();

  /// Relative to 1% of the height of the viewport (device window size). If the viewport is 800px high, 1vh = 8px.
  double get vh => Screen()?.vh(this) ?? toDouble();

  /// Relative to 1% of the width of the viewport (device window size). If the viewport is 500px wide, 1vw = 5px.
  double get vw => Screen()?.vw(this) ?? toDouble();

  /// Relative to the font-size setting of the actual device
  double get sp => Screen()?.sp(this) ?? toDouble();
}
