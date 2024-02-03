import 'package:authentication/authentication/data/model/user_model.dart';
import 'package:authentication/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/repo/base/base.dart';
import '../data/repo/impl/impl.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _auth = getIt.get<AuthRepoImpl>();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<SignInWithGoogleEvent>(_signInWithGoogle);
    on<SignInWithFacebookEvent>(_signInWihFacebook);
  }

  Future<void> _signInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final user = await _auth.signInWithGoogle();

      emit(AuthenticationSuccess(user: user));
    } catch (e) {
      emit(AuthenticationFailure("Error during Google Sign-In: $e"));
    }
  }

  Future<void> _signInWihFacebook(
      SignInWithFacebookEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final user = await _auth.signInWithFacebook();

      emit(AuthenticationSuccess(user: user));
    } catch (e) {
      emit(AuthenticationFailure("Error during Facebook Sign-In: $e"));
    }
  }
}
