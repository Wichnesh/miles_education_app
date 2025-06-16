import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: authController.loginFormKey,
          child: Column(
            children: [
              CustomTextField(
                controller: authController.emailController,
                label: 'Email',
                validator: (val) =>
                val != null && val.isEmail ? null : 'Enter a valid email',
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: authController.passwordController,
                label: 'Password',
                isPassword: true,
                validator: (val) =>
                val != null && val.length >= 6 ? null : 'Minimum 6 characters',
              ),
              const SizedBox(height: 24),
              Obx(() => authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () {
                  if (authController.loginFormKey.currentState!.validate()) {
                    authController.login(
                      authController.emailController.text.trim(),
                      authController.passwordController.text.trim(),
                    );
                  }
                },
                child: const Text('Login'),
              )),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.signup),
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
