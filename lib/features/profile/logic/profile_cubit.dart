import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState.initial());
  void init() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('username');
    final phone = prefs.getString('phoneNumber');
    if (email == null || phone == null) {
      emit(const ProfileState.error(error: 'Une erreur est survenue'));
    }
    else {
      emit(ProfileState.success(email: email, phoneNumber: phone));
    }
  }
}
