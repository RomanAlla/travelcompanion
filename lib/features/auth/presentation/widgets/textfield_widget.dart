import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final void Function()? onTap;
  final bool obscureText;
  final bool isPassword;
  final VoidCallback? onTogglePasswordVisibility;

  const TextFieldWidget({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    required this.controller,
    this.onTap,
    required this.obscureText,
    this.isPassword = false,
    this.onTogglePasswordVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        controller: controller,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[600],
                  ),
                  onPressed: onTogglePasswordVisibility,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        validator: validator);
  }
}
