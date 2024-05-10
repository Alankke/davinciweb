// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/data/repositories/auth/authentication_repository.dart';
import 'package:davinciweb/features/authentication/models/user_model.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Función para guardar usuario en firestore 
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      print('Error de Firebase $e');
      throw FirebaseException(
          code: e.code, message: 'Error en Firebase', plugin: e.plugin);
    } on FormatException catch (_) {
      print("Error de FormatException $_");
      throw const FormatException();
    } catch (e) {
      print("Error producido $e");
      throw 'Se produjo un error y no se pudo registrar en la base de datos';
    }
  }

  //Función para traer todos los datos del usuario
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.emptyUser();
      } 
    } on FirebaseException catch (e) {
      print('Error de Firebase $e');
      throw FirebaseException(
          code: e.code, message: 'Error en Firebase', plugin: e.plugin);
    } on FormatException catch (_) {
      print("Error de FormatException $_");
      throw const FormatException();
    } catch (e) {
      print("Error producido $e");
      throw 'Se produjo un error y no se pudo registrar en la base de datos';
    }
  }

  Future<void> updateUserDetails(UserModel targetUser) async{
    try{
      await _db.collection("Users").doc(targetUser.id).update(targetUser.toJson());
    } on FirebaseException catch (e) {
      print('Error de Firebase $e');
      throw FirebaseException(
          code: e.code, message: 'Error en Firebase', plugin: e.plugin);
    } on FormatException catch (_) {
      print("Error de FormatException $_");
      throw const FormatException();
    } catch (e) {
      print("Error producido $e");
      throw 'Se produjo un error y no se pudo registrar en la base de datos';
    }
  }

  Future<void> deleteUserRecord(String userId) async{
    try{
     await _db.collection("Users").doc(userId).delete(); 
    } on FirebaseException catch (e) {
      print('Error de Firebase $e');
      throw FirebaseException(
          code: e.code, message: 'Error en Firebase', plugin: e.plugin);
    } on FormatException catch (_) {
      print("Error de FormatException $_");
      throw const FormatException();
    } catch (e) {
      print("Error producido $e");
      throw 'Se produjo un error y no se pudo registrar en la base de datos';
    }
  }
}
