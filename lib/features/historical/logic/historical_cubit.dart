import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'historical_state.dart';
part 'historical_cubit.freezed.dart';

class HistoricalCubit extends Cubit<HistoricalState> {
  HistoricalCubit() : super(const HistoricalState.initial());
}
