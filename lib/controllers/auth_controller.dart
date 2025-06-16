import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rxn<User> firebaseUser = Rxn<User>();
  RxBool isLoading = false.obs;

  // Add form and controllers
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  /// Check if user is logged in
  bool isUserLoggedIn() => firebaseUser.value != null;

  /// Get current user
  User? get currentUser => firebaseUser.value;

  /// Login user
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

  /// Signup new user
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

  /// Logout
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  /// Friendly error messages
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
