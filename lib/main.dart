import 'package:flutter/material.dart';
import 'package:wagly/utils/textStyle.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {'/': (context) => Main()},
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Main();
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        'hi',
        style: TextStyle(
          fontFamily: titleL['fontFamily'],
          fontSize: titleL['fontSize'],
        ),
      ),
    );
    ;
  }
}
