import 'package:flutter/material.dart';
import 'package:todo/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: homescreen.routeName,
      routes: {
        homescreen.routeName: (context) => homescreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: homescreen(),
    );
  }
}
