part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.exist() = _Exist;
  const factory LoginState.success({required User user}) = _Success;
  const factory LoginState.error({required String error}) = _Error;
  const factory LoginState.notConnected() = _NotConnected;
}
