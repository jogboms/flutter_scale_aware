# 🎗 Flutter Scale-Aware

### NOT ADVISED FOR PRODUCTION YET. API AND USAGE IS SUBJECT TO CHANGE

[![Build Status - Travis](https://travis-ci.org/jogboms/flutter_scale_aware.svg?branch=master)](https://travis-ci.org/jogboms/flutter_scale_aware) [![codecov](https://codecov.io/gh/jogboms/flutter_scale_aware/branch/master/graph/badge.svg)](https://codecov.io/gh/jogboms/flutter_scale_aware)

Create scale-based layout with a bit more ease. Powered by extensions. 

## 🎖 Installing

```yaml
dependencies:
  flutter_scale_aware: 
    git: 
      url: https://github.com/jogboms/flutter_scale_aware.git
      ref: scale-y
```

### ⚡️ Import

```dart
import 'package:flutter_scale_aware/flutter_scale_aware.dart';
```

## 🎮 How To Use

```dart
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
        home: DemoPage(title: 'Hello'),
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
          height: context.scaleY(2),
          width: context.scale(14.5),
          color: Color.red,
          child: Text("Hello World", style: TextStyle(fontSize: context.fontScale(16))),
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
