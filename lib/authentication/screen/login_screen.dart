import 'package:authentication/authentication/bloc/authentication_bloc.dart';
import 'package:authentication/authentication/screen/widgets/social_button.dart';
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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SocialButton(
                          onTap: () {
                            context
                                .read<AuthenticationBloc>()
                                .add(SignInWithGoogleEvent());
                            print("Clicked");
                          },
                          name: "Google",
                          logo: "assets/google.svg"),
                      const SizedBox(height: 16),
                      SocialButton(
                          name: "Facebook", logo: "assets/facebook.svg"),
                      const SizedBox(height: 16),
                      SocialButton(name: "Apple", logo: "assets/apple.svg"),
                    ],
                  );
                } else if (state is AuthenticationSuccess) {
                  return const Center(
                    child: Text("Congrats"),
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
