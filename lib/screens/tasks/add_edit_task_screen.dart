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
      appBar: AppBar(
        title: Text(_taskController.isEdit ? 'Edit Task' : 'Add Task'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Obx(() => Form(
              key: _taskController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title Heading
                  Text(
                    _taskController.isEdit
                        ? 'Update your task'
                        : 'Create a new task',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please enter the task title and description.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  // Title Input
                  TextFormField(
                    controller: _taskController.titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Enter title'
                        : null,
                  ),
                  const SizedBox(height: 12),

                  // Description Input
                  TextFormField(
                    controller: _taskController.descCtrl,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Enter description'
                        : null,
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  _taskController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () {
                      _taskController.isEdit
                          ? _taskController.updateTask()
                          : _taskController.addTask();
                    },
                    child: Text(_taskController.isEdit
                        ? 'Update Task'
                        : 'Add Task'),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
