import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_codsoft/Models/add_task_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

//firebase firestore services provider
final firebaseFirestoreServicesProvider =
    Provider<FirebaseFirestoreServices>((ref) {
  return FirebaseFirestoreServices();
});

class FirebaseFirestoreServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future createTask(AddTaskModel taskModel) async {
    try {
      DocumentReference documentReference =
          firebaseFirestore.collection("Tasks").doc();
      String taskId = documentReference.id;
      final newTaskWithId = taskModel.copyWith(taskId: taskId);
      await documentReference.set(newTaskWithId.toMap());
      Fluttertoast.showToast(
        msg: "Task Added Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
