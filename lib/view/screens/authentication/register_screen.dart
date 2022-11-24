import 'package:email_validator/email_validator.dart';
import 'package:fawatir_app/controller/sign_up/sign_up_cubit.dart';
import 'package:fawatir_app/view/screens/authentication/login_screen.dart';
import 'package:fawatir_app/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../utils/constants.dart';
import '../../widgets/authentication_widgets/my_app_bar.dart';
import '../../widgets/authentication_widgets/text_field_auth.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "RegisterScreen";
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      user = TextEditingController();
  bool isLoading = false;

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Create Account"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpLoading) {
              isLoading = true;
            } else if (state is SignUpSuccess) {
              isLoading = false;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            } else if (state is SignUpFailure) {
              isLoading = false;
            Constants.getSnackBar(context, state.error, Colors.red);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                    Form(
                      key: form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldAuth(
                              controller: user,
                              obscureText: false,
                              validator: (value) {
                                if (value.toString().isNotEmpty &&
                                    value.toString().trim().length > 5) {
                                  return null;
                                } else {
                                  return "please enter user name five character at least";
                                }
                              },
                              suffixIcon: null,
                              hintText: "User Name"),
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
                              //Provider
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
                      onPressed: () {},
                      child: const Text('Forgot Password'),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            SignUpCubit.get(context).signUp(
                                emailAddress: email.text.trim(),
                                password: password.text);

                            //   Provider.of<AuthController>(context, listen: false)
                            //       .createAccount(
                            //           email: email.text,
                            //           password: password.text,
                            //           username: user.text);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Create My Account'),
                              Icon(Icons.arrow_right_alt)
                            ],
                          ),
                        ),
                      ),
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
