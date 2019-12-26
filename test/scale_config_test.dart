import 'package:flutter_scale_aware/flutter_scale_aware.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("on ScaleConfig", () {
    test('with defaults', () async {
      final instance = ScaleConfig();
      expect(instance.width, 414.0);
      expect(instance.height, 896.0);
      expect(instance.allowFontScaling, true);
    });

    test('with parameters', () async {
      final instance = ScaleConfig(width: 1, height: 2, allowFontScaling: false);
      expect(instance.width, 1);
      expect(instance.height, 2);
      expect(instance.allowFontScaling, false);
    });
  });
}
