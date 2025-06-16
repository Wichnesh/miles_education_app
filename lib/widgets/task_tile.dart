import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task_model.dart';
import '../controllers/task_controller.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(task.description),
        trailing: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                print('[TaskTile] Edit task: ${task.id}');
                Get.toNamed('/add-edit-task', parameters: {'taskId': task.id});
              } else if (value == 'delete') {
                taskController.deleteTask(task.id);
              }
            },
            itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
