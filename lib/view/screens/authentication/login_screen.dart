import 'package:fawatir_app/controller/login/login_cubit.dart';
import 'package:fawatir_app/view/widgets/authentication_widgets/login/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "LoginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LoginCubit(), child: LoginBody());
  }
}
