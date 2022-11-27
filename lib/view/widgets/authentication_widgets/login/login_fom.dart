import 'package:email_validator/email_validator.dart';
import 'package:fawatir_app/view/widgets/authentication_widgets/text_field_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final bool visible;
  final Function changeVisibility;
  final GlobalKey<FormState> form;

  final TextEditingController email, password, user;

  const LoginForm({
    required this.form,
    required this.email,
    required this.password,
    required this.user,
    required this.visible,
    required this.changeVisibility,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldAuth(
              controller: email,
              //obscureText: false,
              validator: (value) {
                if (value != null &&
                    value.isNotEmpty &&
                    EmailValidator.validate(value)) {
                  return null;
                } else {
                  return "Please enter valid email.";
                }
              },
              hintText: 'Email'),
          const SizedBox(height: 20),
          TextFieldAuth(
              controller: password,
              obscureText: visible,
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                } else {
                  return "Please enter 6 characters at least.";
                }
              },
              suffixIcon: IconButton(
                onPressed: () {
                  changeVisibility();
                },
                icon: visible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
              hintText: "Password")
        ],
      ),
    );
  }
}
