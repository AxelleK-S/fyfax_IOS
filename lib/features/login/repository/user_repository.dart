import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  Future<void> logout ()async{
    await Supabase.instance.client.auth.signOut().catchError((err){print('Erro : $err');});
    Supabase.instance.client.auth.refreshSession(); //mettre ici ou après le loginz
  }

}