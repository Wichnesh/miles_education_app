import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:get/get.dart';
import 'package:miles_education_app/controllers/i_auth_controller.dart';
import 'package:flutter/material.dart';

class FakeAuthController extends GetxController implements IAuthController {
  @override
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  RxBool isLoading = false.obs;

  @override
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  @override
  final TextEditingController emailController = TextEditingController();

  @override
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    firebaseUser.value = null;  // Initially set the user to null
    super.onInit();
  }

  @override
  bool isUserLoggedIn() => firebaseUser.value != null;

  @override
  User? get currentUser => firebaseUser.value;

  @override
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    if (email.isNotEmpty && password.isNotEmpty) {
      firebaseUser.value = MockUser();  // Mock user login
    }
    isLoading.value = false;
  }

  @override
  Future<void> signup(String email, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    if (email.isNotEmpty && password.isNotEmpty) {
      firebaseUser.value = MockUser();  // Mock user creation
    }
    isLoading.value = false;
  }

  @override
  Future<void> logout() async {
    firebaseUser.value = null;
  }
}
