import 'package:davinciweb/data/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final userService = Get.put(UserService());

  final _auth = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;

  //Redirige a la pantalla determinada según el rol del usuario
  @override
  void onReady() {
    super.onReady();
    userService.redirect();
  }

  //Crear cuenta
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw 'Se produjo un error y no se pudo registrar su cuenta $e';
    }
  }

  //Iniciar sesión
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw 'Se produjo un error y no se pudo iniciar sesión en su cuenta';
    }
  }  
}