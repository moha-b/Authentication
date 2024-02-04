part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class SignInWithGoogleEvent extends AuthenticationEvent {}

class SignInWithFacebookEvent extends AuthenticationEvent {}

class SignInWithTwitterEvent extends AuthenticationEvent {}

class SignOutEvent extends AuthenticationEvent {}
