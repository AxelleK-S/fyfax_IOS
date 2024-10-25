part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.success() = _Success;
  const factory ProfileState.error({required String error}) = _Error;
  const factory ProfileState.notConnected() = _NotConnected;
}
