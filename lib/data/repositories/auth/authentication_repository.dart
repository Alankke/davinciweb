import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  void onReady() {
    //screenRedirect();
  }

  //Crear cuenta
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw 'Se produjo un error y no se pudo registrar su cuenta';
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
