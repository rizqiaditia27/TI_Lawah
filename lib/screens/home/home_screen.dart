import 'package:flutter/material.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    title: Text(
      'Selamat Datang,',
      style: TextStyle(fontFamily: 'Roboto', fontSize: 22),
    ),
  );
}
