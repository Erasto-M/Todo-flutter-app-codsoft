import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_codsoft/Models/add_task_model.dart';
import 'package:todo_list_codsoft/Services/firebase_firestore_services.dart';
import 'package:todo_list_codsoft/firebase_options.dart';

//Initialize firebase Provider
final initializeFirebaseProvider = FutureProvider(<FirebaseApp>(ref) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return Firebase.app();
});
//controller Providers

final fullNameProvider =
    StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});
final emailProvider = StateProvider.autoDispose<TextEditingController>(
    (ref) => TextEditingController());
final passwordProvider =
    StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});
final confirmPasswordProvider =
    StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

// loading indicator provider
final loadingIndicatorProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
// Homepage Bottom Navigation selected item provider
final selectedIndexProvider = StateProvider<int>((ref) {
  return 0;
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
//get task rom Firebase provider
final getTasksFromFirebaseProvider = StreamProvider((ref) {
  final firebaseServices = ref.watch(firebaseFirestoreServicesProvider);
  return firebaseServices.getTasksFromFirebase() as Stream;
});
