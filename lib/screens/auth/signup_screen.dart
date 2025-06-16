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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: authController.signupFormKey,
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
                  if (authController.signupFormKey.currentState!.validate()) {
                    authController.signup(
                      authController.emailController.text.trim(),
                      authController.passwordController.text.trim(),
                    );
                  }
                },
                child: const Text('Sign Up'),
              )),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
