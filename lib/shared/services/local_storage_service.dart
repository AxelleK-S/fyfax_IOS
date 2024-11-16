import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {

  deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  saveUser(String username, String phoneNumber, int id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('phoneNumber', phoneNumber);
    prefs.setInt('id', id);
  }

  saveToken(String token,) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}