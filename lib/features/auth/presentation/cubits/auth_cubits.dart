/*
Cubits are responsible for State Management -> Which shows the appropriate sutff on the screen
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_sync/features/auth/domain/models/app_user.dart';
import 'package:notes_app_sync/features/auth/domain/repository/auth_repository.dart';
import 'package:notes_app_sync/features/auth/presentation/cubits/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepo;
  AppUser? _currentUser;
  AuthCubit({required this.authRepo}) : super(AuthInitial());
  AppUser? get currentUser => _currentUser;

  //check authentication
  Future<void> checkAuthentication() async {
    try {
      //loading..
      emit(AuthLoading());
      //get current user
      final AppUser? user = await authRepo.getCurrentUser();

      if (user != null) {
        emit(Authenticated(user));
        _currentUser = user;
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  //login with email and password
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());

      final user = await authRepo.loginWithEmailPassword(email, password);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //register with email and password
  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());

      final user =
          await authRepo.registerWithEmailPassword(name, email, password);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //logout
  Future<void> logout() async {
    emit(AuthLoading());
    await authRepo.logout();
    _currentUser = null;
    emit(Unauthenticated());
  }

  //forgot password
  Future<String> forgotPassword(String email) async {
    try {
      emit(AuthLoading());
      final message = await authRepo.sendPasswordResetEmail(email);
      return message;
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
      return e.toString();
    }
  }

  //delete account
  Future<void> deleteAccount() async {
    try {
      emit(AuthLoading());
      await authRepo.deleteAccount();
      _currentUser = null;
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }
}
