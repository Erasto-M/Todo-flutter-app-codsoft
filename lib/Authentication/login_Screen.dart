import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_codsoft/Authentication/Providers.dart';
import 'package:todo_list_codsoft/Authentication/sign_up_screen.dart';
import 'package:todo_list_codsoft/Services/firebase_auth_services.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // controllers
    final emailController = ref.watch(emailProvider);
    final passwordController = ref.watch(passwordProvider);
    final isLoading = ref.watch(loadingIndicatorProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  "Assets/Images/productivity.png",
                  height: 120,
                  width: 160,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.3,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: Form(
                    key: loginFormkey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return "Email field cannot be empty";
                            } else if (!value.contains("@gmail.com")) {
                              return "Please use a valid email address";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return "Please enter your password";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: const Icon(Icons.visibility_off),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : GestureDetector(
                                onTap: () async {
                                  if (loginFormkey.currentState!.validate()) {
                                    ref
                                        .read(loadingIndicatorProvider.notifier)
                                        .state = true;
                                    await ref
                                        .read(firebaseAuthServiceProvider)
                                        .signInUserWithEmailAndPassword(
                                            context: context,
                                            email: emailController.text,
                                            password: passwordController.text);
                                    ref
                                        .read(emailProvider.notifier)
                                        .state
                                        .clear();
                                    ref
                                        .read(passwordProvider.notifier)
                                        .state
                                        .clear();
                                    ref
                                        .read(loadingIndicatorProvider.notifier)
                                        .state = false;
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: const Row(
                              children: [
                                Text(
                                  "Don\'t Have an Account ? ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 15),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
