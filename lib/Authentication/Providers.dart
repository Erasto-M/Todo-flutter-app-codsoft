//controller Providers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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