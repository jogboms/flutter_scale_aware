import 'package:flutter/material.dart';
import 'package:flutter_scale_aware/flutter_scale_aware.dart';
import 'package:flutter_test/flutter_test.dart';

Future<BuildContext> createContext(
  WidgetTester tester,
  Size design,
  Size screen, [
  bool allowFontScaling = false,
]) async {
  tester.binding.window.physicalSizeTestValue = screen;
  tester.binding.window.devicePixelRatioTestValue = 1.0;
  tester.binding.window.textScaleFactorTestValue = 2.0;

  await tester.pumpWidget(ScaleAware(
    child: MaterialApp(home: SizedBox()),
    config: ScaleConfig(width: design.width, height: design.height, allowFontScaling: allowFontScaling),
  ));
  return tester.element(find.byType(SizedBox));
}

void main() {
  group('on scale', () {
    testWidgets('with scale at bigger screen', (WidgetTester tester) async {
      final context = await createContext(tester, Size(100, 200), Size(200, 400));
      expect(context.scale(1), 2);
      expect(context.scale(2), 4);
    });

    testWidgets('with scale at design screen', (WidgetTester tester) async {
      final context = await createContext(tester, Size(100, 200), Size(100, 200));
      expect(context.scale(1), 1);
      expect(context.scale(2), 2);
    });

    testWidgets('with scale at smaller screen', (WidgetTester tester) async {
      final context = await createContext(tester, Size(100, 200), Size(50, 100));
      expect(context.scale(1), .5);
      expect(context.scale(2), 1);
    });

    testWidgets('with scale on landscape', (WidgetTester tester) async {
      final context = await createContext(tester, Size(100, 200), Size(200, 100));
      expect(context.scale(1), 2);
      expect(context.scale(2), 4);
    });
  });

  group('on fontScale', () {
    testWidgets('with scaling', (WidgetTester tester) async {
      final context = await createContext(tester, Size(100, 200), Size(100, 200), true);
      expect(context.fontScale(1), 0.5);
      expect(context.fontScale(0.5), 0.25);
    });

    testWidgets('without scaling', (WidgetTester tester) async {
      final context = await createContext(tester, Size(100, 200), Size(100, 200));
      expect(context.fontScale(1), 1);
      expect(context.fontScale(0.5), 0.5);
    });
  });
}
