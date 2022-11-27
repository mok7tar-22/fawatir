import 'package:fawatir_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../controller/sign_up/sign_up_cubit.dart';
import '../../../screens/authentication/login_screen.dart';
import '../../../screens/home_screen.dart';
import '../auth_button.dart';
import 'sign_up_form.dart';

class SignUpBody extends StatelessWidget {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      user = TextEditingController();

  SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpCubit signUp = SignUpCubit.get(context);
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
              signUp.isLoading = true;
            } else if (state is SignUpSuccess) {
              signUp.isLoading = false;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            } else if (state is SignUpFailure) {
              signUp.isLoading = false;
              Constants.getSnackBar(context, state.error, Colors.red);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: signUp.isLoading,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                    SignUpForm(
                        email: email,
                        password: password,
                        user: user,
                        form: form,
                        visible: signUp.visible,
                        changeVisibility: () {
                          print(signUp.visible);
                          signUp.changeVisibility();
                        }),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AuthButton(
                          text: "Create My Account",
                          validate: () {
                            if (form.currentState!.validate()) {
                              signUp.signUp(
                                  emailAddress: email.text.trim(),
                                  password: password.text);
                            }
                          },
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
