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
      String phone = data.first['phoneNumber'];
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

}