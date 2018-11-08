import 'package:flutter/material.dart';
import 'package:sqlite/data/database_helper.dart';
import 'package:sqlite/models/user.dart';
import 'package:sqlite/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _username, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = LoginPagePresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnacksBar(String text) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    Widget loginBtn = RaisedButton(
      onPressed: _submit,
      child: Text('Login'),
      color: Colors.teal,
    );

    Widget loginForm = Column(
      children: <Widget>[
        Text('App login', textScaleFactor: 2.0),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
              )
            ],
          ),
        ),
        loginBtn,
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Login screen'),
      ),
      key: scaffoldKey,
      body: Container(
        child: Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    _showSnacksBar(error);
  }

  @override
  void onLoginSuccess(User user) async {
    DatabaseHelper db = DatabaseHelper();
    if(await db.validateUser(user)){
      Navigator.of(context).pushNamed('/home');
    }
    await db.saveUser(user);
    _showSnacksBar('User is now registered, press log in again');
  }
}
