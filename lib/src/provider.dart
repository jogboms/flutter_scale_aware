import 'package:flutter/widgets.dart';

import 'config.dart';
import 'screen.dart';

class ScreenAwareProvider extends StatefulWidget {
  const ScreenAwareProvider({
    Key key,
    this.child,
    this.builder,
    this.config = const ScreenConfig(),
  })  : assert(config != null, 'config cannot be null'),
        assert(!(builder == null && child == null), 'You should specify either a builder or a child'),
        super(key: key);

  final Widget child;
  final ValueWidgetBuilder<Screen> builder;
  final ScreenConfig config;

  @override
  _ScreenAwareProviderState createState() => _ScreenAwareProviderState();
}

class _ScreenAwareProviderState extends State<ScreenAwareProvider> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() => setState(() {});

  @override
  void didChangeTextScaleFactor() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final window = WidgetsBinding.instance.window;
    Screen.create(
      size: window.physicalSize,
      pixelRatio: window.devicePixelRatio,
      textScaleFactor: window.textScaleFactor,
      config: widget.config,
    );
    return widget.builder != null ? widget.builder(context, Screen(), widget.child) : widget.child;
  }
}