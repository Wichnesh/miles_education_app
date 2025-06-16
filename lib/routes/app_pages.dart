import 'package:get/get.dart';
import '../bindings/auth_binding.dart';
import '../bindings/task_binding.dart'; // Add this
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/tasks/add_edit_task_screen.dart';
import '../screens/tasks/task_list_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignupScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => TaskListScreen(),
      binding: TaskBinding(), // ✅ FIXED: Uses TaskBinding now
    ),
    GetPage(
      name: '/add-edit-task',
      page: () {
        return AddEditTaskScreen();
      },
      binding: TaskBinding(),
    ),
  ];
}
