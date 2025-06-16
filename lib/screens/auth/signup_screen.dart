import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/custom_text_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: authController.signupFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title
                  const Text(
                    'Create an Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    'Join now to manage your tasks efficiently.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  // Email Field
                  CustomTextField(
                    controller: authController.emailController,
                    label: 'Email',
                    validator: (val) => val != null && val.isEmail
                        ? null
                        : 'Enter a valid email',
                  ),
                  const SizedBox(height: 12),

                  // Password Field
                  CustomTextField(
                    controller: authController.passwordController,
                    label: 'Password',
                    isPassword: true,
                    validator: (val) => val != null && val.length >= 6
                        ? null
                        : 'Minimum 6 characters',
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  Obx(() => authController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () {
                      if (authController.signupFormKey.currentState!
                          .validate()) {
                        authController.signup(
                          authController.emailController.text.trim(),
                          authController.passwordController.text.trim(),
                        );
                      }
                    },
                    child: const Text('Sign Up'),
                  )),

                  // Navigation
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text("Already have an account? Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
