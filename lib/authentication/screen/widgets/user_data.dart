import 'package:authentication/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserData extends StatelessWidget {
  const UserData({
    super.key,
    this.name,
    this.email,
    this.picture,
  });
  final String? name;
  final String? email;
  final String? picture;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                .add(SignOutEvent()),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(picture ??
                "https://www.shutterstock.com/image-vector/user-profile-icon-avatar-person-600nw-2226554633.jpg"),
            Text(name ?? "No data"),
            Text(email ?? "No data"),
          ],
        ),
      ),
    );
  }
}
