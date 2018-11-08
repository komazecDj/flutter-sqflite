import 'package:flutter/material.dart';
import 'package:sqlite/pages/login/login_page.dart';
import 'package:sqlite/pages/home_page.dart';

void main() => runApp(MyApp());

final routes = {
  '/login': (BuildContext context) => LoginPage(),
  '/home': (BuildContext context) => HomeScreen(),
  '/': (BuildContext context) => LoginPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sqliteApp',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}
