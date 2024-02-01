import 'package:authentication/authentication/data/authentication_repo.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'model/user_model.dart';

class AuthRepoImpl extends AuthRepository {
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
  Future<User> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final userData = await FacebookAuth.instance.getUserData();

        return User(
          name: userData["name"],
          email: userData["email"],
          picture: userData["picture"]["data"]["url"],
        );
      } else {
        print("Facebook Sign-In failed. Status: ${result.status}");
        print("Message: ${result.message}");
      }
    } catch (error) {
      print("Error during Facebook Sign-In: $error");
    }
    return User.empty();
  }
}
