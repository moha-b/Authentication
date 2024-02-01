import 'package:authentication/authentication/data/model/user_model.dart';

abstract class AuthRepository {
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
}
