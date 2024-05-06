import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository{

  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;

  //Crear cuenta
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async{
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      throw FirebaseAuthException(code: e.code, message: 'Error en la autenticación de firebase');
    } on FirebaseException catch (e){
      throw FirebaseException(code: e.code, message: 'Error de Firebase', plugin: e.plugin);
    } on FormatException catch (_){
      throw const FormatException();
    } catch (e){
      throw 'Se produjo un error y no se pudo registrar su cuenta';
    }
  }

  //Iniciar sesión
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async{
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      throw FirebaseAuthException(code: e.code, message: 'Error en la autenticación de firebase');
    } on FirebaseException catch (e){
      throw FirebaseException(code: e.code, message: 'Error de Firebase', plugin: e.plugin);
    } on FormatException catch (_){
      throw const FormatException();
    } catch (e){
      throw 'Se produjo un error y no se pudo iniciar sesión en su cuenta';
    }
  }  
}