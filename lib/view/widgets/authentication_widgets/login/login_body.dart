import 'package:fawatir_app/utils/constants.dart';
import 'package:fawatir_app/view/screens/authentication/reset_password_screen.dart';
import 'package:fawatir_app/view/widgets/authentication_widgets/login/login_fom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../controller/login/login_cubit.dart';
import '../../../screens/authentication/sign_up_screen.dart';
import '../../../screens/home_screen.dart';
import '../auth_button.dart';

class LoginBody extends StatelessWidget {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      user = TextEditingController();

  LoginBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginCubit login = LoginCubit.get(context);
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
              login.isLoading = true;
            } else if (state is LoginSuccess) {
              login.isLoading = false;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            } else if (state is LoginFailure) {
              login.isLoading = false;
              Constants.getSnackBar(context, state.error, Colors.red);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: login.isLoading,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                    LoginForm(
                        email: email,
                        password: password,
                        user: user,
                        form: form,
                        visible: login.visible,
                        changeVisibility: login.changeVisibility),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        Navigator.pushReplacementNamed(
                            context, ResetPasswordScreen.routeName);
                      },
                      child: const Text('Forgot Password'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AuthButton(
                        text: "Login",
                        validate: () {
                          if (form.currentState!.validate()) {
                            LoginCubit.get(context).login(
                                emailAddress: email.text,
                                password: password.text);
                          }
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, SignUpScreen.routeName);
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
