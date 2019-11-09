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
        expect(ScreenAwareProvider(child: Text("Hurray")).config, isInstanceOf<ScreenConfig>());
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
}
