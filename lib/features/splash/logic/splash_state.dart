part of 'splash_cubit.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState.initial() = _Initial;
  const factory SplashState.initialized({required bool  isLoggedIn}) = _Initialized;
  const factory SplashState.loading() = _Loading;
  const factory SplashState.success() = _Success;
  const factory SplashState.error({required String error}) = _Error;
  const factory SplashState.notConnected() = _NotConnectesd;
}
