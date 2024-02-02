import 'package:authentication/authentication/bloc/authentication_bloc.dart';
import 'package:authentication/authentication/screen/widgets/facebook_button.dart';
import 'package:authentication/authentication/screen/widgets/google_button.dart';
import 'package:authentication/authentication/screen/widgets/twitter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F1F1),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationInitial) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SignInWithGoogleButton(),
                      SizedBox(height: 16),
                      SignInWithFacebookButton(),
                      SizedBox(height: 16),
                      SignInWithTwitterButton(),
                    ],
                  );
                } else if (state is AuthenticationSuccess) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.user.name!),
                        Text(state.user.email!),
                      ],
                    ),
                  );
                } else if (state is AuthenticationFailure) {
                  return Center(
                    child: Text(state.error),
                  );
                } else {
                  return const Center(
                    child: Text("OOOOPS"),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
