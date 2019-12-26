import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_aware/flutter_scale_aware.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("on parameters", () {
    testWidgets('with null child', (WidgetTester tester) async {
      expect(() => ScaleAware(child: null), throwsAssertionError);
    });

    testWidgets('without config', (WidgetTester tester) async {
      final instance = ScaleAware(child: Text("Hurray"));
      expect(instance.config, isInstanceOf<ScaleConfig>());
      expect(instance.config, const ScaleConfig());
    });

    testWidgets('with null config', (WidgetTester tester) async {
      expect(() => ScaleAware(child: Text("Hurray"), config: null), throwsAssertionError);
    });

    testWidgets('with child', (WidgetTester tester) async {
      await tester.pumpWidget(ScaleAware(child: MaterialApp(home: const Text('child_result'))));
      expect(find.text('child_result'), findsOneWidget);
    });
  });

  group("on setup", () {
    testWidgets('has sane values', (WidgetTester tester) async {
      final data = MediaQueryData.fromWindow(tester.binding.window);
      final scale = Scale(size: data.size, textScaleFactor: data.textScaleFactor, config: const ScaleConfig());
      expect(scale.size, data.size);
      expect(scale.textScaleFactor, data.textScaleFactor);
      expect(scale.config, const ScaleConfig());
    });
  });

  group("on ScaleAware.of", () {
    testWidgets('throws if context is null', (tester) async {
      await tester.pumpWidget(ScaleAware(child: MaterialApp(home: const SizedBox())));

      expect(() => ScaleAware.of(null), throwsAssertionError);
    });

    testWidgets('throws if no ScaleAware', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Builder(
          builder: (BuildContext context) {
            ScaleAware.of(context); // should throw
            return const Text('child_result');
          },
        )),
      );
      final dynamic exception = tester.takeException();
      expect(exception, isNotNull);
      expect(exception, isFlutterError);
      final FlutterError error = exception as FlutterError;
      expect(error.diagnostics.length, 3);
      expect(error.diagnostics.last, isInstanceOf<DiagnosticsProperty<Element>>());
      expect(
        error.toStringDeep(),
        equalsIgnoringHashCodes(
          'FlutterError\n'
          '   ScaleAware.of() called with a context that does not contain a\n'
          '   ScaleAware.\n'
          '   No ScaleAware ancestor could be found starting from the context\n'
          '   that was passed to ScaleAware.of(). This can happen because you\n'
          '   do not have a ScaleAware widget or it can happen if the context\n'
          '   you use comes from a widget above it.\n'
          '   The context used was:\n'
          '     Builder\n',
        ),
      );
    });
  });

  testWidgets('returns proper configuration', (tester) async {
    const config = ScaleConfig();
    await tester.pumpWidget(ScaleAware(config: config, child: MaterialApp(home: const SizedBox())));

    expect(ScaleAware.of(tester.element(find.byType(SizedBox))), config);
  });

  testWidgets('toString diagnostic', (tester) async {
    const config = ScaleConfig(width: 1, height: 1, allowFontScaling: true);
    await tester.pumpWidget(ScaleAware(config: config, child: MaterialApp(home: const SizedBox())));

    expect(tester.allElements.first.toString(), contains('ScaleAware(config: ScaleConfig(1.0, 1.0, true))'));
  });

  testWidgets('config updates notifies dependents only when changed', (WidgetTester tester) async {
    final log = <ScaleAware>[];

    final builder = Builder(builder: (BuildContext context) {
      log.add(context.dependOnInheritedWidgetOfExactType<ScaleAware>());
      return const SizedBox();
    });

    final ScaleAware first = ScaleAware(child: builder);
    await tester.pumpWidget(first);

    expect(log, equals(<ScaleAware>[first]));

    final ScaleAware second = ScaleAware(child: builder);
    await tester.pumpWidget(second);

    expect(log, equals(<ScaleAware>[first]));

    final ScaleAware third = ScaleAware(child: builder, config: ScaleConfig(width: 1, height: 1));
    await tester.pumpWidget(third);

    expect(log, equals(<ScaleAware>[first, third]));

    final ScaleAware forth = ScaleAware(child: builder);
    await tester.pumpWidget(forth);

    expect(log, equals(<ScaleAware>[first, third, forth]));
  });
}
