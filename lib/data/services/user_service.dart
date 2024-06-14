import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/features/shop/screens/admin/admin_home.dart';
import 'package:davinciweb/features/shop/screens/client/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserService {
  static UserService get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Redirigir a pantallas especificas teniendo en cuenta el rol del usuario logueado 
  void redirect() async {
    //Obtiene el usuario logueado
    User? user = _auth.currentUser;

    //Verificar si el usuario logueado no es nulo
    if (user != null) {
      //Trae toda la data del usuario
      DocumentSnapshot docSnapshot = await _db.collection('Users').doc(user.uid).get();
      //Separa el rol
      final role = docSnapshot['Role'];

      //Realiza el redirigido por el rol obtenido del usuario logueado
      if (role == 'admin') {
        Get.to(const AdminHome());
      } else {
        Get.to(const Home());
      }
    }
  }
}
