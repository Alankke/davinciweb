import 'package:davinciweb/data/repositories/auth/authentication_repository.dart';
import 'package:davinciweb/data/services/user_service.dart';
import 'package:davinciweb/features/shop/screens/client/home.dart';
import 'package:davinciweb/utils/constants/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();

  final userService = Get.put(UserService());

  //Form
  final email = TextEditingController();
  final password = TextEditingController();

  //Lógicas
  final hidePassword = true.obs;
  final isLoggedIn = false.obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  
  //Método para validar el estado del formulario e iniciar sesión con Firebase Authentication
  Future<void> emailAndPasswordSignIn() async {
    try {
      //valida el estado del formulario
      if (!loginFormKey.currentState!.validate()) return;
      //Utiliza firebase authentication para iniciar sesión con los campos del formulario
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim()) //Inicia sesión y luego redirige a su pantalla
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
