import 'package:flutter/material.dart';
import 'package:flutter_dpi_aware/flutter_dpi_aware.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenAwareProvider(
      config: ScreenConfig(),
      builder: (_, screen, __) => MaterialApp(
        title: 'Demo',
        theme: ThemeData.dark(),
        home: MyHomePage(title: '${screen.size.width} x ${screen.size.height}'),
      ),
//      child: MaterialApp(
//        title: 'Demo',
//        theme: ThemeData.dark(),
//        home: MyHomePage(title: '${Screen().size.width} x ${Screen().size.height}'),
//      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.dp),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16.dp),
              Container(
                width: 200.dp,
                height: 200.dp,
                color: Colors.red,
                child: Center(child: Text("200.dp \nx\n 200.dp", textAlign: TextAlign.center)),
              ),
              SizedBox(height: 16.dp),
              Container(
                width: 200.vw,
                height: 200.vh,
                color: Colors.blue,
                child: Center(child: Text("200.vw \nx\n 200.vh", textAlign: TextAlign.center)),
              ),
              SizedBox(height: 16.dp),
              Container(
                width: 200,
                height: 200,
                color: Colors.green,
                child: Center(child: Text("200 \nx\n 200", textAlign: TextAlign.center)),
              ),
              SizedBox(height: 16.dp),
              Text(
                'The button is fixed at 40',
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.dp),
              Text(
                'The button is flexible at 40.sp',
                style: TextStyle(fontSize: 40.sp),
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
