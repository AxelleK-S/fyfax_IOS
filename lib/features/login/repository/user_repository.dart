import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fyfax/features/login/model/user.dart' as u;

class UserRepository {

  Future<String?> login(String username, String password) async {
    final AuthResponse data = await Supabase.instance.client.auth.signInWithPassword(
        email: username,
        password: password);
    if (kDebugMode) {
      print(data);
    }
    final Session? session = data.session;
    return session?.accessToken ;
  }
  
  Future<u.User> getUserId(String username) async{
    try {
      final data = await Supabase.instance.client.from('user').select('*').eq('username', username);
      if (kDebugMode) {
        print(data);
      }
      int userId = data.first['id'];
      String phone = data.first['phonenumber'].toString();
      String user = data.first['username'];
      return u.User(id: userId, username: user, phoneNumber: phone);
    } catch (e){
      if (kDebugMode) {
        print(e);
      }
      return u.User(id: 0, username: '', phoneNumber: '');
    }
  }

  Future<void> logout ()async{
    await Supabase.instance.client.auth.signOut().catchError((err){print('Erro : $err');});
    Supabase.instance.client.auth.refreshSession(); //mettre ici ou après le loginz
  }

  Future<String?> createUser (String username, String phoneNumber, String password) async {
    try {
      final AuthResponse data = await  Supabase.instance.client.auth.signUp(
          email: username,
          password: password);
      if (kDebugMode) {
        print(data);
        print(password);
      }
      final Session? session = data.session;
      return session?.accessToken ;
    } catch (e){
      if (kDebugMode) {
        print(e);
      }
      return '';
    }
  }

  Future <List<dynamic>> verifyUserExist(String username) async{
    try {
      final data = await Supabase.instance.client.from('user').select('*').eq('username', username);
      if (kDebugMode) {
        print('data : $data');
      }
      return data;
    } catch (e){
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  Future<void> insertUser (String username, String phoneNumber, String password) async {
    try {
      final data = await Supabase.instance.client.from('user').insert(
          {
            "username" : username,
            "phonenumber" : phoneNumber,
            "connected" : false,
            "code" : password,
          }
      );
      if (kDebugMode) {
        print(data);
      }
    } catch (e){
      if (kDebugMode) {
        print(e);
      }
    }
  }


}