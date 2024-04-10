// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AddTaskModel {
  final String taskName;
  final String taskDescription;
  final String dueDate;
  final DateTime? creationDate;
  final String? taskOwnerId;
  final String? taskId;
  AddTaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.dueDate,
    DateTime? creationDate,
    this.taskOwnerId,
    this.taskId,
  }) : creationDate = DateTime.now();

  AddTaskModel copyWith({
    String? taskName,
    String? taskDescription,
    String? dueDate,
    DateTime? creationDate,
    String? taskOwnerId,
    String? taskId,
  }) {
    return AddTaskModel(
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      dueDate: dueDate ?? this.dueDate,
      creationDate: creationDate ?? this.creationDate,
      taskOwnerId: taskOwnerId ?? this.taskOwnerId,
      taskId: taskId ?? this.taskId,
    );
  }

  String dateFormat = DateFormat('dd-MM-yyyy').format(DateTime.now());
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskName': taskName,
      'taskDescription': taskDescription,
      'dueDate': dueDate,
      'creationDate': dateFormat,
      'taskOwnerId': taskOwnerId,
      'taskId': taskId,
    };
  }

  factory AddTaskModel.fromMap(Map<String, dynamic> map) {
    return AddTaskModel(
      taskName: (map["taskName"] ?? '') as String,
      taskDescription: (map["taskDescription"] ?? '') as String,
      dueDate: (map["dueDate"] ?? '') as String,
      creationDate: (map["creationDate"] != null)
          ? DateFormat('dd-MM-yyyy').parse(map["creationDate"] as String)
          : DateTime.now(),
      taskOwnerId: (map["taskOwnerId"] ?? '') as String,
      taskId: (map["taskId"] ?? '') as String,
    );
  }
}
