import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_codsoft/Authentication/HomePage/home_screen.dart';
import 'package:todo_list_codsoft/Authentication/Providers.dart';
import 'package:todo_list_codsoft/Authentication/login_Screen.dart';
import 'package:todo_list_codsoft/Authentication/sign_up_screen.dart';
import 'package:todo_list_codsoft/Authentication/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initializeFirebase = ref.watch(initializeFirebaseProvider);
    return MaterialApp(
      home: initializeFirebase.when(data: (data) {
        return const HomeScreen();
      }, error: (err, _) {
        return Text(err.toString());
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
      debugShowCheckedModeBanner: false,
    );
  }
}
