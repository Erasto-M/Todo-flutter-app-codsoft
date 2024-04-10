import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_codsoft/Authentication/Providers.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_codsoft/Models/add_task_model.dart';
import 'package:todo_list_codsoft/Services/firebase_firestore_services.dart';

showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final taskNameController = ref.watch(taskNameProvider);
            final taskDescriptionController =
                ref.watch(taskDescriptionProvider);
            final dueDateController = ref.watch(dateControllerProvider);
            final isLoading = ref.watch(loadingIndicatorProvider);
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
                  child: SingleChildScrollView(
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
                              return "Task Description field cannot be empty";
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
                        isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : GestureDetector(
                                onTap: () async {
                                  if (addTaskKey.currentState!.validate()) {
                                    ref
                                        .read(loadingIndicatorProvider.notifier)
                                        .state = true;
                                    AddTaskModel addTaskModel = AddTaskModel(
                                        taskName: taskNameController.text,
                                        taskDescription:
                                            taskDescriptionController.text,
                                        dueDate: dueDateController.text);
                                    await ref
                                        .read(firebaseFirestoreServicesProvider)
                                        .createTask(addTaskModel);
                                  }
                                  ref
                                      .read(taskNameProvider.notifier)
                                      .state
                                      .clear();
                                  ref
                                      .read(taskDescriptionProvider.notifier)
                                      .state
                                      .clear();
                                  ref
                                      .read(dateControllerProvider.notifier)
                                      .state
                                      .clear();
                                  ref
                                      .read(loadingIndicatorProvider.notifier)
                                      .state = false;
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 10),
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
              ),
            );
          },
        );
      });
}
