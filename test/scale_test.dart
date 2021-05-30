import 'package:flutter/material.dart';
import 'package:flutter_scale_aware/flutter_scale_aware.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Scale', () {
    group('on single instance', () {
      test('with same arguments', () async {
        expect(
          Scale(size: const Size(100, 200), textScaleFactor: 2, config: const ScaleConfig(width: 200, height: 400)),
          same(Scale(
            size: const Size(100, 200),
            textScaleFactor: 2,
            config: const ScaleConfig(width: 200, height: 400),
          )),
        );
      });

      test('with same arguments after reset', () async {
        final scale = Scale(
          size: const Size(100, 200),
          textScaleFactor: 2,
          config: const ScaleConfig(width: 200, height: 400),
        );

        expect(
          scale,
          same(Scale(
            size: const Size(100, 200),
            textScaleFactor: 2,
            config: const ScaleConfig(width: 200, height: 400),
          )),
        );

        Scale.reset();

        expect(
          scale,
          isNot(same(Scale(
            size: const Size(100, 200),
            textScaleFactor: 2,
            config: const ScaleConfig(width: 200, height: 400),
          ))),
        );
      });

      test('with off size arguments', () async {
        expect(
          Scale(size: const Size(100, 200), textScaleFactor: 2, config: const ScaleConfig(width: 200, height: 400)),
          isNot(same(Scale(
            size: const Size(200, 400),
            textScaleFactor: 2,
            config: const ScaleConfig(width: 200, height: 400),
          ))),
        );
      });

      test('with off textScaleFactor arguments', () async {
        expect(
          Scale(size: const Size(100, 200), textScaleFactor: 2, config: const ScaleConfig(width: 200, height: 400)),
          isNot(same(Scale(
            size: const Size(100, 200),
            textScaleFactor: 4,
            config: const ScaleConfig(width: 200, height: 400),
          ))),
        );
      });

      test('with off config arguments', () async {
        expect(
          Scale(size: const Size(100, 200), textScaleFactor: 2, config: const ScaleConfig(width: 200, height: 400)),
          isNot(same(Scale(
            size: const Size(100, 200),
            textScaleFactor: 2,
            config: const ScaleConfig(width: 100, height: 200),
          ))),
        );
      });
    });

    test('on toString', () async {
      expect(
        Scale(
          size: const Size(100, 200),
          textScaleFactor: 2,
          config: const ScaleConfig(width: 200, height: 400),
        ).toString(),
        'Scale(textScaleFactor: 2.0, width: 100.0, height: 200.0)',
      );
    });

    group('on scale', () {
      test('with scale at bigger screen', () async {
        final scale = Scale(config: ScaleConfig(width: 100, height: 200), size: Size(200, 400), textScaleFactor: 1);
        expect(scale.scale(1), 2);
        expect(scale.scale(2), 4);
      });

      test('with scale at design screen', () async {
        final scale = Scale(config: ScaleConfig(width: 100, height: 200), size: Size(100, 200), textScaleFactor: 1);
        expect(scale.scale(1), 1);
        expect(scale.scale(2), 2);
      });

      test('with scale at smaller screen', () async {
        final scale = Scale(config: ScaleConfig(width: 100, height: 200), size: Size(50, 100), textScaleFactor: 1);
        expect(scale.scale(1), .5);
        expect(scale.scale(2), 1);
      });

      test('with scale on landscape', () async {
        final scale = Scale(config: ScaleConfig(width: 100, height: 200), size: Size(200, 100), textScaleFactor: 1);
        expect(scale.scale(1), 2);
        expect(scale.scale(2), 4);
      });
    });

    group('on fontScale', () {
      test('with scaling', () async {
        final scale = Scale(config: ScaleConfig(width: 100, height: 200), size: Size(100, 200), textScaleFactor: 2);
        expect(scale.fontScale(1), 0.5);
        expect(scale.fontScale(0.5), 0.25);
      });

      test('without scaling', () async {
        final scale = Scale(
          config: ScaleConfig(width: 100, height: 200, allowFontScaling: false),
          size: Size(100, 200),
          textScaleFactor: 2,
        );
        expect(scale.fontScale(1), 1);
        expect(scale.fontScale(0.5), 0.5);
      });
    });
  });
}
