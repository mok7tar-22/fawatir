import 'package:fawatir_app/view/widgets/authentication_widgets/auth_button.dart';
import 'package:fawatir_app/view/widgets/authentication_widgets/reset_password/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controller/reset_password/reset_password_cubit.dart';
import '../../../../utils/constants.dart';
import '../../../screens/authentication/login_screen.dart';
import '../text_field_auth.dart';

class ResetPasswordBody extends StatelessWidget {
  final Size size;

  ResetPasswordBody({
    Key? key,
    required this.size,
  }) : super(key: key);


  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Forgot password"),
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

                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Image.asset("assets/images/forgetPassword.png"),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    ResetPasswordForm(form: form, email: email),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    AuthButton(text: "Reset Password", validate: () {
                      if (form.currentState!.validate()) {
                        ResetPasswordCubit.get(context)
                            .resetPassword(email: email.text);
                      }
                    },),
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