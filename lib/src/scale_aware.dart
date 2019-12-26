import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'scale_config.dart';

class ScaleAware extends InheritedWidget {
  const ScaleAware({
    Key key,
    this.config = const ScaleConfig(),
    @required Widget child,
  })  : assert(child != null),
        assert(config != null),
        super(key: key, child: child);

  final ScaleConfig config;

  static ScaleConfig of(BuildContext context) {
    assert(context != null);
    final scaleAware = context.dependOnInheritedWidgetOfExactType<ScaleAware>();
    if (scaleAware != null) {
      return scaleAware.config;
    }
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary('ScaleAware.of() called with a context that does not contain a ScaleAware.'),
      ErrorDescription('No ScaleAware ancestor could be found starting from the context that was passed '
          'to ScaleAware.of(). This can happen because you do not have a ScaleAware widget '
          'or it can happen if the context you use comes from a widget above it.'),
      context.describeElement('The context used was')
    ]);
  }

  @override
  bool updateShouldNotify(ScaleAware oldWidget) => config != oldWidget.config;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ScaleConfig>('config', config));
  }
}
