import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/task_controller.dart';

class AddEditTaskScreen extends StatefulWidget {
  const AddEditTaskScreen({super.key});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final TaskController _taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
    _taskController.handleRouteParameters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_taskController.isEdit ? 'Edit Task' : 'Add Task')),
      body: Obx(() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _taskController.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _taskController.titleCtrl,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Enter title' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _taskController.descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Enter description' : null,
              ),
              const SizedBox(height: 20),
              _taskController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () {
                  _taskController.isEdit
                      ? _taskController.updateTask()
                      : _taskController.addTask();
                },
                child: Text(_taskController.isEdit ? 'Update Task' : 'Add Task'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
