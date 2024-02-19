import 'dart:io';

import 'package:authentication/helpers/shared_pref_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/firebase_utils.dart';
import '../../data/user_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  User? user;
  late bool finishedOnBoarding;
  AuthenticationBloc() : super(const AuthenticationState.unauthenticated()) {
    //
    on<SignupWithEmailAndPasswordEvent>(_signUpWithEmailAndPassword);
    on<LoginWithEmailAndPasswordEvent>(_loginWithEmailAndPassword);
    //
    on<FinishedOnBoardingEvent>(_finishedOnboarding);
    on<CheckFirstRunEvent>(_firstRun);
    //
    on<LogoutEvent>(_logOut);
  }

  _firstRun(CheckFirstRunEvent event, Emitter<AuthenticationState> emit) async {
    finishedOnBoarding =
        SharedPrefsHelper.instance?.getBool('FINISHED_ON_BOARDING') ?? false;
    if (!finishedOnBoarding) {
      emit(const AuthenticationState.onboarding());
    } else {
      user = await FireStoreUtils.getAuthUser();
      if (user == null) {
        emit(const AuthenticationState.unauthenticated());
      } else {
        emit(AuthenticationState.authenticated(user!));
      }
    }
  }

  _finishedOnboarding(
      FinishedOnBoardingEvent event, Emitter<AuthenticationState> emit) async {
    await SharedPrefsHelper.instance?.setBool('FINISHED_ON_BOARDING', true);
    emit(const AuthenticationState.unauthenticated());
  }

  _loginWithEmailAndPassword(LoginWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    dynamic result = await FireStoreUtils.loginWithEmailAndPassword(
        event.email, event.password);
    if (result != null && result is User) {
      user = result;
      emit(AuthenticationState.authenticated(user!));
    } else if (result != null && result is String) {
      emit(AuthenticationState.unauthenticated(message: result));
    } else {
      emit(const AuthenticationState.unauthenticated(
          message: 'Login failed, Please try again.'));
    }
  }

  _signUpWithEmailAndPassword(SignupWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    dynamic result = await FireStoreUtils.signUpWithEmailAndPassword(
        emailAddress: event.emailAddress,
        password: event.password,
        image: event.image,
        firstName: event.firstName,
        lastName: event.lastName);
    if (result != null && result is User) {
      user = result;
      emit(AuthenticationState.authenticated(user!));
    } else if (result != null && result is String) {
      emit(AuthenticationState.unauthenticated(message: result));
    } else {
      emit(const AuthenticationState.unauthenticated(
          message: 'Couldn\'t sign up'));
    }
  }

  _logOut(LogoutEvent event, Emitter<AuthenticationState> emit) async {
    await FireStoreUtils.logout();
    user = null;
    emit(const AuthenticationState.unauthenticated());
  }
}
