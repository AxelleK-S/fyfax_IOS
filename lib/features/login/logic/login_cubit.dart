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
      emit(const LoginState.loading());
      try {
        String? pass = await userRepository.login(username, code);
        if (pass!= null){
          User user = await userRepository.getUserId(username);
          int userId = user.id;
          print('userId $userId');
          if (userId !=0){
            await localStorageService.saveUser(username, code, userId, name, user.phoneNumber);
            await localStorageService.saveToken(pass);
            print('saved');
            emit(LoginState.success(user : User(id: userId, username:  username, phoneNumber: code)));
          }
          else {
            emit(const LoginState.error(error: 'Une erreur est survenue'));
          }
        } else {
          emit(const LoginState.error(error: 'Identifiants incorrects'));
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
      emit(const LoginState.loading());
      try {
        await userRepository.logout();
        await localStorageService.deleteAll();
        emit(LoginState.success(user: User(phoneNumber: '', username: '',id: 0)));
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

  Future<void> createUser(String email, String phoneNumber, String pass, String username)async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(const LoginState.notConnected());
    } else {
      emit(const LoginState.loading());
      try {
        final data = await userRepository.verifyUserExist(email);
        //|| data != null
        if (data.isNotEmpty){
          emit(const LoginState.exist());
        }else {
          final userCreate = await userRepository.createUser(email, phoneNumber, pass);
          if (userCreate!= null){
            final userInsert = await userRepository.insertUser(email, phoneNumber, pass);
            User user = await userRepository.getUserId(email);
            int userId = user.id;
            print('userId $userId');
            if (userId !=0){
              await localStorageService.saveUser(email, pass, userId, username, user.phoneNumber);
              await localStorageService.saveToken(pass);
              print('saved');
              emit(LoginState.success(user : User(id: userId, username:  username, phoneNumber: pass)));
            }
            else {
              emit(const LoginState.error(error: 'Erreur lors de l\'insertion de l\'utilisateur'));
            }
          } else {
            emit(const LoginState.error(error: 'Erreur lors de la création de compte'));
          }
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
          emit(const UserState.loading());
          try {
            final data = await userRepository.verifyUserExist(username);
            if (data == [] || data == null){
              emit(const UserState.error(error: 'L\'utilisateur existe déjà'));
            }else {
              String pass = await userRepository.createUser(username, phoneNumber);
              final user = await userRepository.insertUser(username, phoneNumber, pass);
              emit(UserState.success(password: pass));
            }
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
            emit(const UserState.error(error: 'Une erreur est survenue'));
          }
        } else {
          emit(const UserState.notConnected());

          }
          }
    );

     */
  }
}
