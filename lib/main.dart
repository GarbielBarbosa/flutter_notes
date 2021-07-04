import 'package:flutter/material.dart';
import 'package:flutter_notes/src/Login/login_page.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
  Intl.defaultLocale = 'pt_BR';
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Quicksand',
      ),
      home: LoginPage(),
    );
  }
}
