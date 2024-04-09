import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_codsoft/Authentication/Providers.dart';
import 'package:todo_list_codsoft/Authentication/login_Screen.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({super.key});
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //controllers
    final fullnameController = ref.watch(fullNameProvider);
    final emailController = ref.watch(emailProvider);
    final passwordController = ref.watch(passwordProvider);
    final confirmPasswordController = ref.watch(confirmPasswordProvider);
    // isloading indicator
    final isLoading = ref.watch(loadingIndicatorProvider);
    // obsecure Text checkers

    bool obsecurepassWordChecker = true;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
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
                    "Welcome Onboard",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Let\'s help you meet your tasks',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: fullnameController,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return "FullName field cannot be empty";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "FullName",
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
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
                              return "Password field cannot be  empty";
                            } else if (value.length < 6) {
                              return "Password should be at least 6 characters ";
                            }
                            return null;
                          },
                          obscureText: obsecurepassWordChecker,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.visibility_off),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return "Please confirm your password";
                            } else if (value.length < 6) {
                              return "Password should be at least 6 characters ";
                            } else if (value != passwordController.text) {
                              return "Passwords do not Match";
                            }
                            return null;
                          },
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: const Icon(Icons.visibility_off),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (formkey.currentState!.validate()) {
                              print("Form is validate");
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
                              children: [
                                Text(
                                  "Create Account",
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
                                      builder: (context) => LoginScreen()));
                            },
                            child: const Row(
                              children: [
                                Text(
                                  "Already Have an Account ? ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Login",
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
