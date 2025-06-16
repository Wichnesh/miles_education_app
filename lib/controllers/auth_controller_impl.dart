// lib/controllers/auth_controller_impl.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'i_auth_controller.dart';  // Import the interface
import '../routes/app_routes.dart';
import 'package:flutter/material.dart';
class AuthControllerImpl extends GetxController implements IAuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  @override
  bool isUserLoggedIn() => firebaseUser.value != null;

  @override
  User? get currentUser => firebaseUser.value;

  @override
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Failed", _handleAuthError(e),
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> signup(String email, String password) async {
    isLoading.value = true;
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Signup Failed", _handleAuthError(e),
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with that email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'That email is already in use.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'invalid-email':
        return 'That email address is invalid.';
      default:
        return e.message ?? 'Authentication error.';
    }
  }
}
