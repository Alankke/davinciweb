import 'package:davinciweb/data/repositories/auth/authentication_repository.dart';
import 'package:davinciweb/features/authentication/models/user_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Rx<UserModel> _user = UserModel.emptyUser().obs;
  UserModel get user => _user.value;

  //Método para guardar usuario en firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } catch (e) {
      throw 'Se produjo un error y no se pudo registrar en la base de datos $e';
    }
  }

  //Método para traer todos los datos del usuario logueado al momento
  Future<void> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
     if (documentSnapshot.exists) {
        _user.value = UserModel.fromSnapshot(documentSnapshot);
      } else {
        _user.value = UserModel.emptyUser();
      }
    } catch (e) {
      throw 'Se produjo un error y no se pudo registrar en la base de datos';
    }
  }

  //Método para actualizar los detalles de los usuarios
  Future<void> updateUserDetails(UserModel targetUser) async {
    try {
      await _db
          .collection("Users")
          .doc(targetUser.id)
          .update(targetUser.toJson());
    } catch (e) {
      throw 'Se produjo un error y no se pudo registrar en la base de datos';
    }
  }
  //Actualizar un solo campo del usuario y guardarlo en firestore
  Future<void> updateSingleFields(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } catch (e) {
      throw 'Se produjo un error y no se pudo registrar en la base de datos';
    }
  }

  //Método para eliminar los detalles de los usuarios
  Future<void> deleteUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } catch (e) {
      throw 'Se produjo un error y no se pudo registrar en la base de datos';
    }
  }
  //Función para subir foto de perfil a storage
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      return await ref.getDownloadURL();
    } catch (e) {
      throw 'Se produjo un error y no se pudo subir su imagen en la base de datos';
    }
  }
}
