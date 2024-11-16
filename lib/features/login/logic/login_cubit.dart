import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fyfax/features/login/repository/user_repository.dart';
import 'package:fyfax/shared/services/local_storage_service.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository userRepository = UserRepository();
  final LocalStorageService localStorageService = LocalStorageService();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  LoginCubit() : super(const LoginState.initial());



  Future<void> login(String username, String phoneNumber)async {
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(
            (result) async {
          if (!result.contains(ConnectivityResult.none)) {
            const LoginState.loading();
            try {
              String? pass = await userRepository.login(username, phoneNumber);
              if (pass!= null){
                await localStorageService.saveUser(username, phoneNumber);
                await localStorageService.saveToken(pass);
                const LoginState.success();
              } else {
                emit(const LoginState.error(error: 'Une erreur est survenue'));
              }
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
  }

  Future<void> logout()async {
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(
            (result) async {
          if (!result.contains(ConnectivityResult.none)) {
            const LoginState.loading();
            try {
              await userRepository.logout();
              await localStorageService.deleteAll();
              const LoginState.success();
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
  }
}
