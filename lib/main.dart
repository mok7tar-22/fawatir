import 'package:fawatir_app/controller/login/login_cubit.dart';
import 'package:fawatir_app/controller/reset_password/reset_password_cubit.dart';
import 'package:fawatir_app/controller/sign_up/sign_up_cubit.dart';
import 'package:fawatir_app/view/screens/authentication/forget_password_screen.dart';
import 'package:fawatir_app/view/screens/authentication/login_screen.dart';
import 'package:fawatir_app/view/screens/authentication/register_screen.dart';
import 'package:fawatir_app/view/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBL_YsOqNH_b1o63dwstc6_KKPxG5OUFD0",
          projectId: "fawatir-b7838",
          storageBucket: "fawatir-b7838.appspot.com",
          messagingSenderId: "709571332229",
          appId: "1:709571332229:web:30d8a3bac8e5b1066ac1ec"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => ResetPasswordCubit(),
        ),
      ],

      child: MaterialApp(
          title: 'Flutter Demo',
        routes: {
        LoginScreen.routeName: (context) =>LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
         ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
         HomeScreen.routeName: (context) => HomeScreen(),

        },
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.transparent,
            primarySwatch: Colors.blue,
          ),
          home:StreamBuilder(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                }
                if (snapshot.data != null) {
                  return HomeScreen();
                } else {
                  return LoginScreen();
                }
              }),
      ),
    );
  }
}

