import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/services/local_storage_service.dart';
import '../../login/repository/user_repository.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository = UserRepository();
  final LocalStorageService localStorageService = LocalStorageService();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  ProfileCubit() : super(const ProfileState.initial());
  void init() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('username');
    final phone = prefs.getString('phoneNumber');
    final name = prefs.getString('name');
    if (email == null || phone == null || name == null) {
      emit(const ProfileState.error(error: 'Une erreur est survenue'));
    }
    else {
      emit(ProfileState.success(email: email, phoneNumber: phone, name: name));
    }
  }

  Future<void> logout()async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(const ProfileState.notConnected());
    } else {
      emit(const ProfileState.loading());
      try {
        await userRepository.logout();
        await localStorageService.deleteAll();
        emit(const ProfileState.done());
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(const ProfileState.error(error: 'Une erreur est survenue'));
      }
    }

    /*
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(
            (result) async {
          if (!result.contains(ConnectivityResult.none)) {
            const LoginState.loading();
            try {
              await userRepository.logout();
              await localStorageService.deleteAll();
              LoginState.success(user: User(phoneNumber: '', username: '',id: 0));
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
              emit(const LoginState.error(error: 'Une erreur est survenue'));
            }
          } else {
            emit(const LoginState.notConnected());

          }
        }
    );

     */
  }

  Future<void> deleteUser(String userMail)async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(const ProfileState.notConnected());
    } else {
      emit(const ProfileState.loading());
      try {
        await userRepository.deleteUser(userMail);
        await localStorageService.deleteAll();
        emit(const ProfileState.done());
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(const ProfileState.error(error: 'Une erreur est survenue'));
      }
    }

  }
}
