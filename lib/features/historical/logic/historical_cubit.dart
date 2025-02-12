import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fyfax/features/historical/model/historical.dart';
import 'package:fyfax/features/historical/repository/historical_repository.dart';
import 'package:fyfax/shared/services/hive_service.dart';
import 'package:fyfax/shared/hive/model/historical.dart' as hs;
import 'package:shared_preferences/shared_preferences.dart';

part 'historical_state.dart';
part 'historical_cubit.freezed.dart';

class HistoricalCubit extends Cubit<HistoricalState> {
  final HistoricalRepository historicalRepository = HistoricalRepository();
  final HiveService hiveService = HiveService();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  HistoricalCubit() : super(const HistoricalState.initial());

  Future<void> getHistorical2()async {
    print('debut');
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      try{
        emit(const HistoricalState.notConnected());
        emit(const HistoricalState.loading());
        List<hs.Historical> historical = await hiveService.getAllHistorical();

        if (historical == []){
          emit(const HistoricalState.empty());
        } else {
          List<Historical> historicalList = [];

          for (var hist in historical){
            historicalList.add(Historical.fromJson(hist.toJson()));
            if (kDebugMode) {
              print(hist.toJson());
            }
          }
          emit(HistoricalState.success(historical: historicalList));
        }
      } catch (e){
        emit(const HistoricalState.error(error: 'Une erreur est survenue'));
      }
    } else {
      print('load');
      emit(const HistoricalState.loading());
      try {
        print('recup');
        final prefs = await SharedPreferences.getInstance();
        final id = prefs.getInt('id');
        if (id != null ){
          List<Historical> historical = await historicalRepository.getHistorical(id);
          if (historical == []){
            emit(const HistoricalState.empty());
          } else {
            emit(HistoricalState.success(historical: historical));
          }
        } else {
          emit(const HistoricalState.error(error: 'Une erreur est survenue'));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(const HistoricalState.error(error: 'Une erreur est survenue'));
      }
    }
    /*
    try {
      print('recup');
      List<Historical> historical = await historicalRepository.getHistorical(1);
      if (historical == []){
        emit(const HistoricalState.empty());
      } else {
        emit(HistoricalState.success(historical: historical));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(const HistoricalState.error(error: 'Une erreur est survenue'));
    }

     */

    /*
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(
            (result) async {
          if (!result.contains(ConnectivityResult.none)) {
            print('load');
            emit(const HistoricalState.loading());
            try {
              print('recup');
              final prefs = await SharedPreferences.getInstance();
              final id = prefs.getInt('id');
              if (id != null ){
                List<Historical> historical = await historicalRepository.getHistorical(id);
                if (historical == []){
                  emit(const HistoricalState.empty());
                } else {
                  emit(HistoricalState.success(historical: historical));
                }
              } else {
                emit(const HistoricalState.error(error: 'Une erreur est survenue'));
              }
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
              emit(const HistoricalState.error(error: 'Une erreur est survenue'));
            }
          } else {
            try{
              emit(const HistoricalState.notConnected());
              emit(const HistoricalState.loading());
              List<hs.Historical> historical = await hiveService.getAllHistorical();

              List<Historical> historicalList = [];

              for (var hist in historical){
                historicalList.add(Historical.fromJson(hist.toJson()));
                if (kDebugMode) {
                  print(hist.toJson());
                }
              }
              emit(HistoricalState.success(historical: historicalList));
            } catch (e){
              emit(const HistoricalState.error(error: 'Une erreur est survenue'));
            }
          }
        }
    );

     */
  }

  Future<void> getHistorical() async {
    try{
      emit(const HistoricalState.notConnected());
      emit(const HistoricalState.loading());
      List<hs.Historical> historical = await hiveService.getAllHistorical();

      if (historical == []){
        emit(const HistoricalState.empty());
      } else {
        List<Historical> historicalList = [];

        for (var hist in historical){
          historicalList.add(Historical.fromJson(hist.toJson()));
          if (kDebugMode) {
            print(hist.toJson());
          }
        }
        emit(HistoricalState.success(historical: historicalList));
      }
    } catch (e){
      emit(const HistoricalState.error(error: 'Une erreur est survenue'));
    }
  }
}
