import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app_network_call_pratice/screens/home_screen.dart';
import 'package:post_app_network_call_pratice/styles/app_color.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: AppBGColors.normalMode,
      ),
      darkTheme: ThemeData.dark().copyWith(
          primaryColor: AppBGColors.darkMode
      ),
      home: HomePage(),
    );
  }
}
