import 'screen.dart';

extension ScreenAwareExtensions<T extends num> on T {
  /// Device-independent pixels. The unit is relative to a 160 dpi screen,
  /// so one dp is equivalent to one pixel on a 160dpi screen, and equals two pixels for a 320dpi screen.
  double get dp => Screen()?.dp(this) ?? this;

  /// Relative to 1% of the height of the viewport (device window size). If the viewport is 800px high, 1vh = 8px.
  double get vh => Screen()?.vh(this) ?? this;

  /// Relative to 1% of the width of the viewport (device window size). If the viewport is 500px wide, 1vw = 5px.
  double get vw => Screen()?.vw(this) ?? this;

  double get sp => Screen()?.sp(this) ?? this;
}
