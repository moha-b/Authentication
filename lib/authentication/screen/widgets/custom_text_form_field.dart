import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.keyboardType,
    this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: labelText, border: const OutlineInputBorder()),
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
    );
  }
}
