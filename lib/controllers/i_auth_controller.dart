// lib/controllers/i_auth_controller.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class IAuthController {
  Rxn<User> get firebaseUser;
  RxBool get isLoading;

  GlobalKey<FormState> get loginFormKey;
  GlobalKey<FormState> get signupFormKey;

  TextEditingController get emailController;
  TextEditingController get passwordController;

  bool isUserLoggedIn();
  User? get currentUser;

  Future<void> login(String email, String password);
  Future<void> signup(String email, String password);
  Future<void> logout();
}
