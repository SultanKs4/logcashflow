import 'package:flutter/material.dart';

class PasswordFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final String hintText;
  final IconData icon;

  const PasswordFormWidget({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.labelText,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: labelText,
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 2),
          ),
        ),
      ),
    );
  }
}
