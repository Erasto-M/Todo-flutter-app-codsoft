import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

// Create Task in Firebase
  Future createTask(AddTaskModel taskModel) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final currentUserId = currentUser.uid;
        DocumentReference documentReference =
            firebaseFirestore.collection("Tasks").doc();
        String taskId = documentReference.id;
        final newTaskWithId =
            taskModel.copyWith(taskId: taskId, taskOwnerId: currentUserId);
        await documentReference.set(newTaskWithId.toMap());
        Fluttertoast.showToast(
          msg: "Task Added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
        );
      }
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

  // Fetch Task From firebase
  Stream<List<AddTaskModel>> getTasksFromFirebase() {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final currentUserId = currentUser.uid;
        return firebaseFirestore
            .collection("Tasks")
            .where("taskOwnerId", isEqualTo: currentUserId)
            .snapshots()
            .map((event) =>
                event.docs.map((e) => AddTaskModel.fromMap(e.data())).toList());
      }
    } catch (e) {
      print(e.toString());
    }
    return Stream.value([]);
  }

  // update Task in firebase
  Future updateTask() async {
    try {} catch (e) {}
  }

  // Delete Task From Firebase
  deleteTask(String taskId) {
    try {
      final firebaseRef = firebaseFirestore.collection("Tasks");
      firebaseRef.doc(taskId).delete();
      Fluttertoast.showToast(
        msg: "Task Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
    } on FirebaseException catch (e) {
      print("error deleting task ${e.toString()}");
    } catch (e) {
      print(e.toString());
    }
  }
}
