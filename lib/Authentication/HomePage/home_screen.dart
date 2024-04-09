import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_codsoft/Authentication/Providers.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAlertDialogCalled = ref.watch(callAlertDialogProvider);
    return SafeArea(
      child: Scaffold(
          body: const SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Consumer(
            builder: (context, ref, child) {
              return FloatingActionButton(
                onPressed: () {
                  final showDialogCurrentState =
                      ref.read(callAlertDialogProvider.notifier).state = true;
                  if (showDialogCurrentState) {
                    return _showAlertDialog(context);
                  } else {
                    const SizedBox();
                  }
                },
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                tooltip: "Add Task in TODO List",
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              );
            },
          )),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Consumer(
            builder: (context, ref, child) {
              final taskNameController = ref.watch(taskNameProvider);
              final taskDescriptionController =
                  ref.watch(taskDescriptionProvider);
              final dueDateController = ref.watch(dateControllerProvider);
              GlobalKey<FormState> addTaskKey = GlobalKey<FormState>();
              return AlertDialog(
                shape: const RoundedRectangleBorder(),
                title: const Center(
                    child: Text(
                  "Add A Task",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                )),
                content: Container(
                  height: 400,
                  child: Form(
                    key: addTaskKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: taskNameController,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return "Task name field cannot be empty";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Task Name",
                            prefixIcon: const Icon(Icons.title_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: taskDescriptionController,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return "Task Name field cannot be empty";
                            }
                            return null;
                          },
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Task Description",
                            prefixIcon: const Icon(Icons.description_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: dueDateController,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return "Please select a due date ";
                            }
                            return null;
                          },
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Task due date",
                            prefixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                initialDate: DateTime.now(),
                                lastDate: DateTime(2025));
                            if (pickedDate != null) {
                              String dateFormat = DateFormat("dd - MM - yyyy")
                                  .format(pickedDate);
                              ref.read(dateControllerProvider.notifier).state =
                                  TextEditingController(text: dateFormat);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (addTaskKey.currentState!.validate()) {
                              print("Alert Dialog verifed");
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Create Task",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
