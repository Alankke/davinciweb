// ignore_for_file: avoid_print

import 'package:davinciweb/data/repositories/auth/authentication_repository.dart';
import 'package:davinciweb/data/repositories/user/user_repository.dart';
import 'package:davinciweb/features/personalization/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO: Pop up de éxito y de error.

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //Form
  final email = TextEditingController();
  final name = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();

  //Lógicas
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final hidePassword = true.obs;

  void signup() async {
    try {
      if (!signupFormKey.currentState!.validate()) return;

      final userData = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      final user = UserModel(
          id: userData.user!.uid,
          name: name.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(user);

      print('Usuario registrado');
    } catch (e) {
      print('Error en el registro de usuario $e');
    }
  }
}
