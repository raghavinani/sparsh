import 'package:flutter/material.dart';

import 'package:sprash_arch/core/constants/theme.dart';

Widget customTextField({
  required TextEditingController controller,
  required String hintText,
  bool obscureText = false,
  void Function(String)? onChanged,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      fillColor: Colors.grey.shade100,
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(
        color: AppTheme().primaryColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onChanged: onChanged,
  );
}