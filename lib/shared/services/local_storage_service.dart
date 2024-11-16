import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {

  deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  saveUser(String username, String phoneNumber,) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('phoneNumber', phoneNumber);
  }

  saveToken(String token,) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}