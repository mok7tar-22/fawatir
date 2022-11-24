import 'package:flutter/material.dart';

class Constants {
  static const decoration = BoxDecoration(
    color: Colors.white,
    image: DecorationImage(
      image: AssetImage('assets/images/background.png'),
      fit: BoxFit.fill,
    ),
  );

  static getCategoryImage(String category) {
    return AssetImage(
      'assets/images/${category == 'Sports' ? 'sports' : category == 'Movies' ? 'movies' : 'music'}.png',
    );
  }

  static getSnackBar(context, String title, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title),
      backgroundColor: color,
    ));
  }
}
