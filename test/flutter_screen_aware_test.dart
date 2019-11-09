import 'package:flutter/material.dart';
import 'package:flutter_screen_aware/flutter_screen_aware.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("UI tests", () {
    group("on parameters", () {
      testWidgets('with none', (WidgetTester tester) async {
        expect(() => ScreenAwareProvider(), throwsAssertionError);
      });

      testWidgets('without config', (WidgetTester tester) async {
        final instance = ScreenAwareProvider(child: Text("Hurray"));
        expect(instance.config, isInstanceOf<ScreenConfig>());
        expect(instance.config, const ScreenConfig());
      });

      testWidgets('with null config', (WidgetTester tester) async {
        expect(() => ScreenAwareProvider(child: Text("Hurray"), config: null), throwsAssertionError);
      });

      group("with builder", () {
        testWidgets('and no child', (WidgetTester tester) async {
          await tester.pumpWidget(ScreenAwareProvider(
            builder: (_, __, ___) => MaterialApp(home: Text('builder_result')),
          ));
          expect(find.text('builder_result'), findsOneWidget);
        });

        testWidgets('and child', (WidgetTester tester) async {
          await tester.pumpWidget(ScreenAwareProvider(
            builder: (_, __, child) => child,
            child: MaterialApp(home: Text('child_result')),
          ));
          expect(find.text('child_result'), findsOneWidget);
        });
      });

      testWidgets('with child', (WidgetTester tester) async {
        await tester.pumpWidget(ScreenAwareProvider(
          child: MaterialApp(home: const Text('child_result')),
        ));
        expect(find.text('child_result'), findsOneWidget);
      });
    });

    group("on observers", () {
      testWidgets('on first run', (WidgetTester tester) async {
        final instance = ScreenAwareProvider(child: MaterialApp(home: const Text('child_result')));
        await tester.pumpWidget(instance);
        final window = tester.binding.window;
        expect(Screen().size, window.physicalSize / window.devicePixelRatio);
        expect(Screen().pixelRatio, window.devicePixelRatio);
        expect(Screen().textScaleFactor, window.textScaleFactor);
        expect(Screen().config, instance.config);
      });

      testWidgets('on update', (WidgetTester tester) async {
        final instance = ScreenAwareProvider(child: MaterialApp(home: const Text('child_result')));
        await tester.pumpWidget(instance);
        final window = tester.binding.window;
        window.physicalSizeTestValue = const Size(1, 2);
        window.textScaleFactorTestValue = 2;
        window.devicePixelRatioTestValue = 3;
        await tester.pump();
        expect(Screen().size, const Size(1, 2) / 3);
        expect(Screen().pixelRatio, 3);
        expect(Screen().textScaleFactor, 2);
      });
    });

    group("on setup", () {
      setUp(() => Screen.reset());

      testWidgets('without provider', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: Text('Hurray')));
        expect(() => Screen(), throwsException);
      });

      testWidgets('without provider but with Screen.create', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: Text('Hurray')));
        final window = tester.binding.window;
        Screen.create(
          size: window.physicalSize,
          pixelRatio: window.devicePixelRatio,
          textScaleFactor: window.textScaleFactor,
          config: const ScreenConfig(),
        );
        expect(Screen().size, window.physicalSize / window.devicePixelRatio);
        expect(Screen().pixelRatio, window.devicePixelRatio);
        expect(Screen().textScaleFactor, window.textScaleFactor);
        expect(Screen().config, const ScreenConfig());
      });
    });
  });

  group("Unit tests", () {
    group("on ScreenConfig", () {
      test('with defaults', () async {
        final instance = ScreenConfig();
        expect(instance.width, 414.0);
        expect(instance.height, 896.0);
        expect(instance.allowFontScaling, true);
      });

      test('with parameters', () async {
        final instance = ScreenConfig(width: 1, height: 2, allowFontScaling: false);
        expect(instance.width, 1);
        expect(instance.height, 2);
        expect(instance.allowFontScaling, false);
      });
    });

    group("on Screen", () {
      setUpAll(() {
        Screen.create(
          size: const Size(100, 200),
          pixelRatio: 2,
          textScaleFactor: 2,
          config: const ScreenConfig(width: 200, height: 400),
        );
      });

      tearDownAll(() => Screen.reset());

      test("with any null parameters", () async {
        expect(
          () => Screen.create(size: null, pixelRatio: null, textScaleFactor: null, config: null),
          throwsAssertionError,
        );
        expect(
          () => Screen.create(size: Size.zero, pixelRatio: null, textScaleFactor: 1, config: const ScreenConfig()),
          throwsAssertionError,
        );
        expect(
          () => Screen.create(size: Size.zero, pixelRatio: 1, textScaleFactor: null, config: const ScreenConfig()),
          throwsAssertionError,
        );
        expect(
          () => Screen.create(size: Size.zero, pixelRatio: 1, textScaleFactor: 1, config: null),
          throwsAssertionError,
        );
      });

      test('on single instance', () async {
        expect(Screen(), Screen());
      });

      test('on toString', () async {
        expect(Screen().toString(), "Screen(textScaleFactor: 2.0, pixelRatio: 2.0, width: 50.0, height: 100.0)");
      });

      group("on extensions", () {
        test('with dp', () async {
          expect(1.dp, 0.25);
          expect(0.5.dp, 0.125);
        });

        test('with vh', () async {
          expect(1.vh, 0.25);
          expect(0.5.vh, 0.125);
        });

        test('with vw', () async {
          expect(1.vw, 0.25);
          expect(0.5.vw, 0.125);
        });

        group('on sp', () {
          test('with scaling', () async {
            expect(1.sp, 0.5);
            expect(0.5.sp, 0.25);
          });

          test('without scaling', () async {
            Screen.copyWith(
              config: const ScreenConfig(width: 200, height: 400, allowFontScaling: false),
            );
            expect(1.sp, 1);
            expect(0.5.sp, 0.5);
          });
        });
      });

      test('on copyWith', () async {
        expect(Screen.copyWith(config: null), Screen());
      });
    });
  });
}
