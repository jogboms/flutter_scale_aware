import 'package:flutter/material.dart';
import 'package:flutter_scale_aware/flutter_scale_aware.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaleAware(
      config: ScaleConfig(),
      child: MaterialApp(
        title: 'Demo',
        theme: ThemeData.dark(),
        home: _MyHomePage(title: 'Hello'),
      ),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  const _MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.scale(7)),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: context.scale(16)),
              Text(
                'Designed at ${ScaleAware.of(context).width} x ${ScaleAware.of(context).height}',
                style: TextStyle(fontSize: context.fontScale(16)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.scale(16)),
              _Boxes(size: Size.square(context.scale(100)), color: Colors.red, label: ["100dp", "100dp"]),
              SizedBox(height: context.scale(16)),
              _Boxes(size: Size.square(100), color: Colors.blue, label: ["100", "100"]),
              SizedBox(height: context.scale(16)),
              Text(
                'The text is fixed at 24',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.scale(16)),
              Text(
                'The text is flexible at 24',
                style: TextStyle(fontSize: context.fontScale(24)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.scale(48)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Boxes extends StatelessWidget {
  const _Boxes({this.size, this.color, this.label, Key key}) : super(key: key);

  final Size size;
  final Color color;
  final List<String> label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        4,
        (_) => Container(
          width: size.width,
          height: size.height,
          color: color,
          child: Center(
            child: Text(
              label.join("\nx\n"),
              style: TextStyle(fontSize: context.fontScale(14)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
