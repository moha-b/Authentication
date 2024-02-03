part of 'impl.dart';

class TwitterSignInImpl implements ITwitterSignIn {
  final twitterLogin = TwitterLogin(
    apiKey: 'zwvMuyP9q5NGsBGkTBHcSEHdp',
    apiSecretKey: 'lcy0EaBhBy2XWmm752BMoNjOM4NzlPIOgXSaYDmRCa7xZdokyI',
    redirectURI: 'https://github.com/moha-b',
  );

  @override
  Future<User> signInWithTwitter() async {
    try {
      final authResult = await twitterLogin.login(forceLogin: true);

      switch (authResult.status) {
        case TwitterLoginStatus.loggedIn:
          return User(
            name: authResult.user!.name,
            email: authResult.user!.screenName,
            picture: authResult.user!.thumbnailImage,
          );

        case TwitterLoginStatus.cancelledByUser:
          print('Twitter Sign-In cancelled by user');
          break;

        case TwitterLoginStatus.error:
          print('Twitter Sign-In error: ${authResult.errorMessage}');

        case null:
          print('Twitter Sign-In IS Null: ${authResult.errorMessage}');
      }
    } catch (error) {
      print('Error during Twitter Sign-In: $error');
    }

    return User.empty();
  }

  @override
  Future<void> signOut() async {
    // Check this issue on Github
    // https://github.com/0maru/twitter_login/issues/5#issuecomment-721158658
    print("The Package don't provide a method to logging out ");
  }
}
