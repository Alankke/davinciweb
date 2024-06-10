import 'package:davinciweb/data/repositories/auth/authentication_repository.dart';
import 'package:davinciweb/data/services/user_service.dart';
import 'package:davinciweb/features/shop/screens/client/home.dart';
import 'package:davinciweb/utils/constants/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();

  final userService = Get.put(UserService());

  // Form
  final email = TextEditingController();
  final password = TextEditingController();

  // Lógicas
  final hidePassword = true.obs;
  final isLoggedIn = false.obs;
  final localStorage = GetStorage();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> emailAndPasswordSignIn() async {
    try {
      if (!loginFormKey.currentState!.validate()) return;

      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim())
          .then((user) async {
            isLoggedIn.value = true;
            userService.redirect();
      });
      DaVinciSnackBars.success('Inicio de sesión exitoso');
    } catch (e) {
      DaVinciSnackBars.error('Se ha producido un error al intentar iniciar sesión, intente nuevamente más tarde');
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    isLoggedIn.value = false;
    Get.offAll(() => const Home());
  }
}
