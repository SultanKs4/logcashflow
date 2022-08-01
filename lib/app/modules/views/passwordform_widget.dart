import 'package:flutter/material.dart';

class PasswordFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final String hintText;
  final IconData icon;
  final Color color;

  const PasswordFormWidget({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.color,
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
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: color, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: color, width: 2),
          ),
        ),
      ),
    );
  }
}
