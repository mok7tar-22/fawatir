import 'package:flutter/material.dart';
class TextFieldAuth extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final Function validator;
  final Widget? suffixIcon;
  final String hintText;
  const TextFieldAuth(
      {Key? key,
        required this.controller,
        required this.obscureText,
        required this.validator,
        required this.suffixIcon,
        required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: Colors.black,
        keyboardType: TextInputType.text,
        validator: (value)=>validator(value),
        decoration: InputDecoration(

          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
