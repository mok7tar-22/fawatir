import 'package:flutter/material.dart';

import '../../screens/authentication/login_screen.dart';

class MyAppBar extends StatelessWidget {
  final String title;

  const MyAppBar({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(title),
    );
  }
}
