import 'package:davinciweb/data/repositories/auth/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogInController extends GetxController{
  static LogInController get instance => Get.find();

  //Form
  final email = TextEditingController();
  final password = TextEditingController();

  //Lógicas
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> emailAndPasswordSignIn() async {
    try{

      if (!loginFormKey.currentState!.validate()) return;

      final userData = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      
      print('Inicio de sesión exitoso');

    } catch (e){
      print('Error en el inicio de sesión $e');
    }
  }
}