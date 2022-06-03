import 'package:flutter/material.dart';
import 'package:ti_lawah/screens/home/home_screen.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TI_Lawah',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: bluePrimary,
      ),
      home: HomeScreen(),
    );
  }
}
