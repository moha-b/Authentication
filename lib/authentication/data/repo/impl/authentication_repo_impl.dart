part of 'impl.dart';

class AuthRepoImpl implements AuthRepository {
  final IGoogleSignIn _google;
  final IFacebookSignIn _facebook;
  final ITwitterSignIn _twitter;

  AuthRepoImpl(this._google, this._facebook, this._twitter);

  @override
  Future<User> signInWithGoogle() async {
    return await _google.signInWithGoogle();
  }

  @override
  Future<User> signInWithFacebook() async {
    return await _facebook.signInWithFacebook();
  }

  @override
  Future<User> signInWithTwitter() async {
    return await _twitter.signInWithTwitter();
  }

  @override
  Future<void> signOut() async {
    await _google.signOut();
    await _facebook.signOut();
    await _twitter.signOut();
  }
}
