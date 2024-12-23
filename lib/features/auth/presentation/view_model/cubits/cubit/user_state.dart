part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class SignInSuccess extends UserState {}

final class SignInLoading extends UserState {}

final class SignInFailure extends UserState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}

final class SignUpSuccess extends UserState {
  final String message;

  SignUpSuccess({required this.message});
}

final class SignUpLoading extends UserState {}

final class SignUpFailure extends UserState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}

final class GetUserSuccess extends UserState {
  final UserModel userModel;

  GetUserSuccess({required this.userModel});
}

final class GetUserLoading extends UserState {}

final class GetUserFailure extends UserState {
  final String errMessage;

  GetUserFailure({required this.errMessage});
}

final class UpdateUserSuccess extends UserState {
  final UserModel userModel;

  UpdateUserSuccess({required this.userModel});
}

final class UpdateUserLoading extends UserState {}

final class UpdateUserFailure extends UserState {
  final String errMessage;

  UpdateUserFailure({required this.errMessage});
}

final class LogoutLoading extends UserState {}

final class LogoutSuccess extends UserState {}

final class LogoutFailure extends UserState {
  final String errMessage;

  LogoutFailure({required this.errMessage});
}
