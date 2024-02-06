import 'package:authentication/authentication/screen/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(
                'assets/firebase.webp',
                width: double.infinity,
                height: 250,
              ),
              const SizedBox(height: 16),
              const SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
