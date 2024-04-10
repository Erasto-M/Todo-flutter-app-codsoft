import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_codsoft/firebase_options.dart';

//Initialize firebase Provider
final initializeFirebaseProvider = FutureProvider(<FirebaseApp>(ref) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return Firebase.app();
});
//controller Providers

final fullNameProvider = Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});
final emailProvider = Provider.autoDispose<TextEditingController>(
    (ref) => TextEditingController());
final passwordProvider = Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});
final confirmPasswordProvider =
    Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

// loading indicator provider
final loadingIndicatorProvider = Provider<CircularProgressIndicator>((ref) {
  return const CircularProgressIndicator();
});
// obscure Text providers
get obsecureSignupPasswordProvider => StateProvider<bool>((ref) {
      return true;
    });
get obsecureSignupConfirmPasswordProvider => StateProvider<bool>((ref) {
      return true;
    });
get obsecureSignInPasswordProvider => StateProvider<bool>((ref) {
      return true;
    });

// call alert dialog Provider
final callAlertDialogProvider = StateProvider<bool>((ref) => false);

//Add Task Providers (task Name , Task Description , Task due date)
final taskNameProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
final taskDescriptionProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
// Task Due Date Provider
final dateControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
