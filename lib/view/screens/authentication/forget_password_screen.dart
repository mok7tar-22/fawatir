import 'package:email_validator/email_validator.dart';
import 'package:fawatir_app/controller/reset_password/reset_password_cubit.dart';
import 'package:fawatir_app/view/screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import '../../widgets/authentication_widgets/text_field_auth.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "ForgetScreen";

  ForgotPasswordScreen({Key? key}) : super(key: key);
  final email = TextEditingController();
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Forgot password"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: BlocListener<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) async {
            if (state is ResetPasswordSuccess) {
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              await Constants.getSnackBar(
                  context,
                  "reset password link send to your email, please check your email",
                  Colors.green);
            } else if (state is ResetPasswordFailure) {
              Constants.getSnackBar(context, state.error, Colors.red);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'If you want to recover your account, then please provide your email ID below..',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Image.asset("assets/images/forgetPassword.png"),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Form(
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
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (form.currentState!.validate()) {
                          ResetPasswordCubit.get(context)
                              .resetPassword(email: email.text);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Forget Password'),
                            Icon(Icons.arrow_right_alt)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
