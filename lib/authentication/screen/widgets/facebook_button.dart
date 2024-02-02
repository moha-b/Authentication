import 'package:authentication/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignInWithFacebookButton extends StatelessWidget {
  const SignInWithFacebookButton({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => BlocProvider.of<AuthenticationBloc>(context)
          .add(SignInWithFacebookEvent()),
      child: Container(
        width: 300,
        height: 48,
        decoration: BoxDecoration(
            color: const Color(0xff1877F2),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/facebook.svg", width: 20, height: 20),
            const SizedBox(width: 16),
            const Text("Continue with Facebook",
                style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
