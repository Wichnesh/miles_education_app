import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task_model.dart';

class TaskController extends GetxController {
  final tasks = <TaskModel>[].obs;
  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  final _tasksRef = FirebaseFirestore.instance.collection('tasks');

  String? currentTaskId;

  bool get isEdit => currentTaskId != null;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void handleRouteParameters() {
    currentTaskId = Get.parameters['taskId'];
    if (isEdit) {
      loadTaskToForm(currentTaskId!);
    } else {
      clearForm();
    }
    print('[TaskController] isEdit: $isEdit');
  }

  void fetchTasks() {
    isLoading.value = true;
    print('[TaskController] Fetching tasks...');
    _tasksRef.orderBy('createdAt', descending: true).snapshots().listen((snapshot) {
      tasks.value = snapshot.docs.map((doc) {
        final task = TaskModel.fromMap(doc.data(), doc.id);
        return task;
      }).toList();
      isLoading.value = false;
    }, onError: (err) {
      isLoading.value = false;
      print('[TaskController] Error fetching tasks: $err');
    });
  }

  void clearForm() {
    titleCtrl.clear();
    descCtrl.clear();
  }

  void loadTaskToForm(String taskId) {
    final task = getTaskById(taskId);
    if (task != null) {
      titleCtrl.text = task.title;
      descCtrl.text = task.description;
    }
  }

  TaskModel? getTaskById(String id) {
    return tasks.firstWhereOrNull((task) => task.id == id);
  }

  Future<void> addTask() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final newTask = TaskModel(
        id: '',
        title: titleCtrl.text.trim(),
        description: descCtrl.text.trim(),
        createdAt: DateTime.now(),
      );

      await _tasksRef.add(newTask.toMap());
      Get.back();
      Get.snackbar('Success', 'Task added');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add task');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTask() async {
    if (!formKey.currentState!.validate() || currentTaskId == null) return;

    isLoading.value = true;
    try {
      await _tasksRef.doc(currentTaskId).update({
        'title': titleCtrl.text.trim(),
        'description': descCtrl.text.trim(),
      });
      Get.back();
      Get.snackbar('Success', 'Task updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTask(String taskId) async {
    isLoading.value = true;
    try {
      await _tasksRef.doc(taskId).delete();
      Get.snackbar('Deleted', 'Task has been deleted');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task');
    } finally {
      isLoading.value = false;
    }
  }
}
