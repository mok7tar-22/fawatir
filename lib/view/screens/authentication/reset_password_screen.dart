
import 'package:fawatir_app/controller/reset_password/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/authentication_widgets/reset_password/reset_password_body.dart';


class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = "ForgetScreen";

  ResetPasswordScreen({Key? key}) : super(key: key);
  final email = TextEditingController();
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: ResetPasswordBody(size: size),
    );
  }
}


