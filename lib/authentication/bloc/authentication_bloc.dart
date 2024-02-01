import 'package:authentication/authentication/data/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/authentication_repo.dart';
import '../data/authentication_repo_impl.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository = AuthRepoImpl();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<SignInWithGoogleEvent>(_signInWithGoogle);
    on<SignInWithFacebookEvent>(_signInWihFacebook);
  }

  Future<void> _signInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final user = await _authRepository.signInWithGoogle();

      if (user != null) {
        emit(AuthenticationSuccess(user: user));
      } else {
        emit(AuthenticationFailure("Sign-in with Google failed"));
      }
    } catch (e) {
      emit(AuthenticationFailure("Error during Google Sign-In: $e"));
    }
  }

  Future<void> _signInWihFacebook(
      SignInWithFacebookEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final user = await _authRepository.signInWithFacebook();

      if (user != null) {
        emit(AuthenticationSuccess(user: user));
      } else {
        emit(AuthenticationFailure("Sign-in with Facebook failed"));
      }
    } catch (e) {
      emit(AuthenticationFailure("Error during Facebook Sign-In: $e"));
    }
  }
}
