import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_codsoft/Authentication/HomePage/home_screen.dart';
import 'package:todo_list_codsoft/Authentication/login_Screen.dart';
import 'package:todo_list_codsoft/Authentication/sign_up_screen.dart';
import 'package:todo_list_codsoft/Authentication/splashScreen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
