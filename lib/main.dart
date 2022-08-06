import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wagly/screens/index.dart';

void main() {
  runApp(const HeroApp());
}

class HeroApp extends StatelessWidget {
  const HeroApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wagly',
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Screen(),
    );
  }
}

// stless
