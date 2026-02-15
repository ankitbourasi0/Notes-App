/*
Auth States- Outline of all Possible state for Authentication
*/

import 'package:notes_app_sync/features/auth/domain/models/app_user.dart';

abstract class AuthState {}

//Initial
class AuthInitial extends AuthState {}

//loading..
class AuthLoading extends AuthState {}

//Authenticated
class Authenticated extends AuthState {
  final AppUser user;
  Authenticated(this.user);
}

//Unauthenticated
class Unauthenticated extends AuthState {}

//AuthError
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
