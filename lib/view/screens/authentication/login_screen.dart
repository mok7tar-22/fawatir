import 'package:email_validator/email_validator.dart';
import 'package:fawatir_app/controller/login/login_cubit.dart';
import 'package:fawatir_app/view/screens/authentication/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../utils/constants.dart';
import '../../widgets/authentication_widgets/text_field_auth.dart';
import '../home_screen.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName="LoginScreen";
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController(),
      password = TextEditingController();
  bool isLoading = false;

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: const Text('Login'),
        ),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              isLoading = true;
            } else if (state is LoginSuccess) {
              isLoading = false;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            } else if (state is LoginFailure) {
              isLoading = false;
              Constants.getSnackBar(context, state.error, Colors.red);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldAuth(
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
                              suffixIcon: null,
                              hintText: 'Email'),
                          const SizedBox(height: 20),
                          TextFieldAuth(
                              controller: password,
                              obscureText: true,
                              // Provider
                              //     .of<AuthController>(context)
                              //     .visible,
                              validator: (value) {
                                if (value != null && value.length >= 6) {
                                  return null;
                                } else {
                                  return "Please enter 6 characters at least.";
                                }
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  // Provider.of<AuthController>(
                                  //     context, listen: false).changeVisible();
                                },
                                icon: Icon(Icons.visibility),
                              ),
                              // Provider
                              //     .of<AuthController>(context)
                              //     .visible
                              //     ? Icon(Icons.visibility)
                              //     : Icon(Icons.visibility_off)),
                              hintText: "Password")
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        Navigator.pushReplacementNamed(context, ForgotPasswordScreen.routeName);
                      },
                      child: const Text('Forgot Password'),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (form.currentState!.validate()) {
                            LoginCubit.get(context).login(
                                emailAddress: email.text,
                                password: password.text);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Login'),
                              Icon(Icons.arrow_right_alt)
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                      },
                      child: const Text('Or Create My Account'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
