import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.hint,
    this.obscure = false,
    this.icon = const Icon(Icons.person), 
    required this.controller,
  });

  final String hint;
  final bool obscure;
  final Icon icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          icon: icon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}