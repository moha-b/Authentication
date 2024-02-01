import 'package:authentication/authentication/data/authentication_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepoImpl extends AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      if (googleAccount != null) {
        final GoogleSignInAuthentication googleAuthentication =
            await googleAccount.authentication;
        print({
          'provider': 'google',
          'account': googleAccount,
          'authentication': googleAuthentication,
        });
        return {
          'provider': 'google',
          'account': googleAccount,
          'authentication': googleAuthentication,
        };
      }
    } catch (error) {
      print("Error during Google Sign-In: $error");
    }
    return null;
  }
}
