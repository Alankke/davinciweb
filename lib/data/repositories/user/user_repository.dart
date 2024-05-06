import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/features/personalization/models/user_model.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      print('Error de Firebase $e');
      throw FirebaseException(code: e.code, message: 'Error en Firebase', plugin: e.plugin);
    } on FormatException catch (_) {
      print("Error de FormatException $_");
      throw const FormatException();
    } catch (e) {
      print("Error producido $e");
      throw 'Se produjo un error y no se pudo registrar en la base de datos';
    }
  }
}
