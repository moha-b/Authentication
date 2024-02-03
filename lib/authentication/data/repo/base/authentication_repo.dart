part of 'base.dart';

abstract class AuthRepository
    with IGoogleSignIn, IFacebookSignIn, ITwitterSignIn {}
