part of 'impl.dart';

class GoogleSignInImpl implements IGoogleSignIn {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      if (googleAccount != null) {
        final GoogleSignInAuthentication googleAuthentication =
            await googleAccount.authentication;

        return User(
          name: googleAccount.displayName,
          email: googleAccount.email,
          picture: googleAccount.photoUrl,
        );
      }
    } catch (error) {
      print("Error during Google Sign-In: $error");
    }
    return User.empty();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
