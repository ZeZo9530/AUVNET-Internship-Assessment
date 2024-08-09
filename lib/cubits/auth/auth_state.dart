part of 'auth_cubit.dart';

//i know i will go so much hate from this
//but time wasn't by my side xd
@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthToggle extends AuthState {
  final bool isLogin;
  AuthToggle({required this.isLogin});
}

final class AuthSignup extends AuthState {}

final class SignupSuccess extends AuthState {}

final class LoginSuccess extends AuthState {}

final class AuthFailed extends AuthState {
  final String error;

  AuthFailed({required this.error});
}
