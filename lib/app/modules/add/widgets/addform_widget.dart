import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onTap;
  final String labelText;
  final String hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final IconData icon;

  const AddFormWidget({
    Key? key,
    required this.controller,
    this.onTap,
    required this.labelText,
    required this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: labelText,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
