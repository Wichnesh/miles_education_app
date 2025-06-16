import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/task_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/task_tile.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({super.key});

  final TaskController taskController = Get.find<TaskController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
        actions: [
          IconButton(
            onPressed: () async {
              await authController.logout();
              Get.offAllNamed(AppRoutes.login);
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Obx(() {
        if (taskController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (taskController.tasks.isEmpty) {
          return const Center(child: Text("No tasks found."));
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          itemCount: taskController.tasks.length,
          itemBuilder: (_, index) {
            final task = taskController.tasks[index];
            return TaskTile(task: task);
          },
          separatorBuilder: (_, __) => const SizedBox(height: 6),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add-edit-task');
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
