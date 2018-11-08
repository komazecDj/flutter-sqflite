import 'package:sqlite/data/rest_data.dart';
import 'package:sqlite/models/user.dart';

abstract class LoginPageContract {
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class LoginPagePresenter {
  LoginPageContract _view;
  RestData api = RestData();
  LoginPagePresenter(this._view);

  doLogin(String username, String password) {
    api
        .login(username, password)
        .then((User user) => _view.onLoginSuccess(user))
        .catchError((String onError) => _view.onLoginError(onError));
  }
}