import 'package:davinciweb/data/repositories/auth/authentication_repository.dart';
import 'package:davinciweb/data/repositories/user/user_repository.dart';
import 'package:davinciweb/features/authentication/models/user_model.dart';
import 'package:davinciweb/utils/constants/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //Form
  final email = TextEditingController();
  final name = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;

  //Lógicas
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();  
  

  //Método para validar el estado del formulario y crear cuenta con userRepository
  void signup() async {
    try {
      if (!signupFormKey.currentState!.validate()) return;
      //Registra usuario nuevo en Firebase Authentication
      final userData = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      //Llena un UserModel con los datos ingresados por el usuario
      final user = UserModel(
          id: userData.user!.uid,
          name: name.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          role: 'cliente',
          profilePicture: '');

      //Llama a la clase repository para registrar el usuario en firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(user);
      DaVinciSnackBars.success('Su usuario ha sido registrado');
    } catch (e) {
      DaVinciSnackBars.error('Se ha producido un error, intente nuevamente más tarde');
    }
  }
}
