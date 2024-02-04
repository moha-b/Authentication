part of 'impl.dart';

class FacebookSignInImpl implements IFacebookSignIn {
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

  @override
  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
    print("Sign-out from \'Facbook\'");
  }
}
