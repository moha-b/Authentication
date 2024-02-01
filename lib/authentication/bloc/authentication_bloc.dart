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
  }

  Future<void> _signInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final Map<String, dynamic>? result =
          await _authRepository.signInWithGoogle();

      if (result != null) {
        emit(AuthenticationSuccess(data: result));
      } else {
        emit(AuthenticationFailure("Sign-in with Google failed"));
      }
    } catch (e) {
      emit(AuthenticationFailure("Error during Google Sign-In: $e"));
    }
  }
}
