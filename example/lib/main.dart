import 'package:flutter/material.dart';
import 'package:flutter_screen_aware/flutter_screen_aware.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenAwareProvider(
      config: ScreenConfig(),
      builder: (_, screen, __) => MaterialApp(
        title: 'Demo',
        theme: ThemeData.dark(),
        home: _MyHomePage(title: '${screen.size.width} x ${screen.size.height}'),
      ),
//      child: MaterialApp(
//        title: 'Demo',
//        theme: ThemeData.dark(),
//        home: _MyHomePage(title: '${Screen().size.width} x ${Screen().size.height}'),
//      ),
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
        padding: EdgeInsets.symmetric(horizontal: 7.dp),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16.dp),
              Text(
                'Designed at ${Screen().config.width} x ${Screen().config.height}',
                style: TextStyle(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.dp),
              _Boxes(size: Size.square(100.dp), color: Colors.red, label: ["100dp", "100dp"]),
              SizedBox(height: 16.dp),
              _Boxes(size: Size(100.vw, 100.vh), color: Colors.green, label: ["100vw", "100vh"]),
              SizedBox(height: 16.dp),
              _Boxes(size: Size.square(100), color: Colors.blue, label: ["100", "100"]),
              SizedBox(height: 16.dp),
              Text(
                'The text is fixed at 24',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.dp),
              Text(
                'The text is flexible at 24.sp',
                style: TextStyle(fontSize: 24.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.dp),
              Text(
                Screen().toString(),
                style: TextStyle(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.dp),
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
              style: TextStyle(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
