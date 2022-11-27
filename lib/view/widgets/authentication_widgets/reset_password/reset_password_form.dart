import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../text_field_auth.dart';

class ResetPasswordForm extends StatelessWidget {
  final GlobalKey<FormState> form ;
  final TextEditingController email;
  const ResetPasswordForm({Key? key, required this.form, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: TextFieldAuth(
          controller: email,
          obscureText: false,
          validator: (value) {
            if (value != null &&
                value.isNotEmpty &&
                EmailValidator.validate(value)) {
              return null;
            } else {
              return "Please enter valid email.";
            }
          },
          // prefixIcon: Icons.email_outlined,
          suffixIcon: null,
          hintText: "Email"),
    );
  }
}
