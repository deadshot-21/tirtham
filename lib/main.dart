import 'package:flutter/material.dart';
import 'package:tirtham/screens/home/home.dart';

import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
    );
  }
}
