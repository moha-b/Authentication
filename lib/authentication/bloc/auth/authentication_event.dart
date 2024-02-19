part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class LoginWithEmailAndPasswordEvent extends AuthenticationEvent {
  String email;
  String password;

  LoginWithEmailAndPasswordEvent({required this.email, required this.password});
}

class SignupWithEmailAndPasswordEvent extends AuthenticationEvent {
  String emailAddress;
  String password;
  File? image;
  String? firstName;
  String? lastName;

  SignupWithEmailAndPasswordEvent(
      {required this.emailAddress,
      required this.password,
      this.image,
      this.firstName = 'Anonymous',
      this.lastName = 'User'});
}

class LogoutEvent extends AuthenticationEvent {
  LogoutEvent();
}

class FinishedOnBoardingEvent extends AuthenticationEvent {}

class CheckFirstRunEvent extends AuthenticationEvent {}
