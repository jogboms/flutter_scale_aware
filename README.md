# 🎗 Flutter Screen-Aware

[![Build Status - Travis](https://travis-ci.org/jogboms/flutter_screen_aware.svg?branch=master)](https://travis-ci.org/jogboms/flutter_screen_aware) [![codecov](https://codecov.io/gh/jogboms/flutter_screen_aware/branch/master/graph/badge.svg)](https://codecov.io/gh/jogboms/flutter_screen_aware)

## 🎖 Installing

```yaml
dependencies:
  flutter_screen_aware: 
    git: https://github.com/jogboms/flutter_screen_aware.git
```

### ⚡️ Import

```dart
import 'package:flutter_screen_aware/flutter_screen_aware.dart';
```

## 🎮 Tease

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screen_aware/flutter_screen_aware.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenAwareProvider(
      config: ScreenConfig(),
      builder: (_, screen, child) => MaterialApp(
        title: 'Demo',
        theme: ThemeData.dark(),
        home: DemoPage(title: '${screen.size.width} x ${screen.size.height}'),
      ),
    );
  }
}

class DemoPage extends StatelessWidget {
  DemoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Container(
          height: 2.dp,
          width: 14.5.vw,
          color: Color.red,
          child: Text("Hello World", style: TextStyle(fontSize: 16.sp)),
        ),
      ),
    );
  }
}
```

For more info, please, refer to the `main.dart` in the example.

## 🐛 Bugs/Requests

If you encounter any problems feel free to open an issue. If you feel the library is
missing a feature, please raise a ticket on Github and I'll look into it.
Pull request are also welcome.

### ❗️ Note

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

For help on editing plugin code, view the [documentation](https://flutter.io/platform-plugins/#edit-code).


## ⭐️ License

MIT License
