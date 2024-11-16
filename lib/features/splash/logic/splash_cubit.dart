import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';
part 'splash_cubit.freezed.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.initial());

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('token');
    if (accessToken == null) {
      emit(const SplashState.initialized(isLoggedIn: false));
      return;
    }
    else {
      emit(const SplashState.initialized(isLoggedIn: true));
    }
  }
}
