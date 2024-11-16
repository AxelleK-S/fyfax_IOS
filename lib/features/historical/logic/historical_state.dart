part of 'historical_cubit.dart';

@freezed
class HistoricalState with _$HistoricalState {
  const factory HistoricalState.initial() = _Initial;
  const factory HistoricalState.loading() = _Loading;
  const factory HistoricalState.success({required List<Historical> historical}) = _Success;
  const factory HistoricalState.empty() = _Empty;
  const factory HistoricalState.error({required String error}) = _Error;
  const factory HistoricalState.notConnected() = _NotConnected;
}
