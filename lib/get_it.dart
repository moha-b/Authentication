import 'package:authentication/authentication/data/repo/impl/impl.dart';
import 'package:get_it/get_it.dart';

import 'authentication/data/repo/base/base.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerSingleton<IGoogleSignIn>(GoogleSignInImpl());
  getIt.registerSingleton<IFacebookSignIn>(FacebookSignInImpl());
  getIt.registerSingleton<ITwitterSignIn>(TwitterSignInImpl());
  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(getIt.get<IGoogleSignIn>(), getIt.get<IFacebookSignIn>(),
        getIt.get<ITwitterSignIn>()),
  );
}
