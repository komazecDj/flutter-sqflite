import 'package:flutter/material.dart';
import 'package:sqlite/data/database_helper.dart';

class HomeScreen extends StatelessWidget {
  Future<List<Map>> onLoginSuccess() async {
    DatabaseHelper db = DatabaseHelper();
    return await db.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    onLoginSuccess();
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Text('HOME PAGE!'),
      ),
    );
  }
}
