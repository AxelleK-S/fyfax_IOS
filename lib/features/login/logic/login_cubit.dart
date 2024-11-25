import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fyfax/features/login/model/user.dart';
import 'package:fyfax/features/login/repository/user_repository.dart';
import 'package:fyfax/shared/services/local_storage_service.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository userRepository = UserRepository();
  final LocalStorageService localStorageService = LocalStorageService();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  LoginCubit() : super(const LoginState.initial());



  Future<void> login(String username, String code, String name)async {

    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(const LoginState.notConnected());
    } else {
      const LoginState.loading();
      try {
        String? pass = await userRepository.login(username, code);
        if (pass!= null){
          User user = await userRepository.getUserId(username);
          int userId = user.id;
          print(userId);
          if (userId !=0){
            await localStorageService.saveUser(username, code, userId, name, user.phoneNumber);
            await localStorageService.saveToken(pass);
            LoginState.success(user : User(id: userId, username:  username, phoneNumber: code));
          }
          else {
            emit(const LoginState.error(error: 'Une erreur est survenue'));
          }
        } else {
          emit(const LoginState.error(error: 'Une erreur est survenue'));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(const LoginState.error(error: 'Une erreur est survenue'));
      }
    }

    /*
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(
            (result) async {
          if (!result.contains(ConnectivityResult.none)) {
            const LoginState.loading();
            try {
              String? pass = await userRepository.login(username, code);
              if (pass!= null){
                User user = await userRepository.getUserId(username);
                int userId = user.id;
                print(userId);
                if (userId !=0){
                  await localStorageService.saveUser(username, code, userId, name, user.phoneNumber);
                  await localStorageService.saveToken(pass);
                  LoginState.success(user : User(id: userId, username:  username, phoneNumber: code));
                }
                else {
                  emit(const LoginState.error(error: 'Une erreur est survenue'));
                }
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

     */
  }

  Future<void> logout()async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(const LoginState.notConnected());
    } else {
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
}
