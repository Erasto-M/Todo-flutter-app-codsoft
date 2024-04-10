import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_codsoft/Authentication/HomePage/add_task_dialog.dart';
import 'package:todo_list_codsoft/Authentication/Providers.dart';
import 'package:todo_list_codsoft/Models/add_task_model.dart';
import 'package:todo_list_codsoft/Services/firebase_auth_services.dart';
import 'package:todo_list_codsoft/Services/firebase_firestore_services.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTasksFromFirebase = ref.watch(getTasksFromFirebaseProvider);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    ref.read(firebaseAuthServiceProvider).signOutUser(context);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
            ],
            backgroundColor: Colors.blue,
            title: const Text(
              "My Tasks",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: getTasksFromFirebase.when(data: (data) {
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  // reference to the add task model
                  AddTaskModel tasks = data[index];
                  if (data != null) {
                    return Container(
                        margin:
                            const EdgeInsets.only(left: 5, right: 5, top: 5),
                        // ignore: prefer_const_constructors
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  offset: Offset(0, 0.3))
                            ]),
                        child: ListTile(
                          leading: const Checkbox(
                            value: false,
                            onChanged: null,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks.taskName,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                tasks.taskDescription,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [Text("Task Due  ${tasks.dueDate}")],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              ref
                                  .read(firebaseFirestoreServicesProvider)
                                  .deleteTask(tasks.taskId!);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.blue,
                            ),
                          ),
                        ));
                  } else {
                    return const Center(
                      child: Text(
                          "No Tasks Added Yet , Click the Add button to add a task"),
                    );
                  }
                });
          }, error: (err, stackTrace) {
            return Text(err.toString());
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }),
          //Floating action button
          // calls alert dialog when pressed
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Consumer(
            builder: (context, ref, child) {
              return FloatingActionButton(
                onPressed: () {
                  final showDialogCurrentState =
                      ref.read(callAlertDialogProvider.notifier).state = true;
                  if (showDialogCurrentState) {
                    // ignore: void_checks
                    return showAlertDialog(context);
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
}
