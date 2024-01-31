import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    this.onTap,
    required this.name,
    required this.logo,
  });
  final Function()? onTap;
  final String name;
  final String logo;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 48,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(logo, width: 20, height: 20),
            const SizedBox(width: 16),
            Text("Continue with $name"),
          ],
        ),
      ),
    );
  }
}
