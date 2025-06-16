// test/mocks/fake_auth_controller.dart

import 'package:get/get.dart';
import 'package:miles_education_app/controllers/i_auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool isUserLoggedIn() => firebaseUser.value != null;

  @override
  User? get currentUser => firebaseUser.value;

  @override
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading.value = false;
    firebaseUser.value = null; // Simulate login success
  }

  @override
  Future<void> signup(String email, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading.value = false;
  }

  @override
  Future<void> logout() async {
    firebaseUser.value = null;
  }
}
