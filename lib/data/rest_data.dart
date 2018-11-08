import 'package:sqlite/utils/network_util.dart';
import 'package:sqlite/models/user.dart';

class RestData {
  NetworkUtil _netUtil = NetworkUtil();
  static final BASE_URL = '';
  static final LOGIN_URL = BASE_URL + '/';

  Future<User> login (String username, String password) {
    return Future.value(User(username, password));
  }
}