import 'package:authentication/authentication/screen/widgets/social_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SocialButton(name: "Google", logo: "assets/google.svg"),
              SizedBox(height: 16),
              SocialButton(name: "Facebook", logo: "assets/facebook.svg"),
              SizedBox(height: 16),
              SocialButton(name: "Apple", logo: "assets/apple.svg"),
            ],
          ),
        ),
      ),
    );
  }
}
