import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/features/shop/screens/admin/admin_home.dart';
import 'package:davinciweb/features/shop/screens/client/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserService {
  static UserService get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void redirect() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot docSnapshot = await _db.collection('Users').doc(user.uid).get();
      final role = docSnapshot['Role'];

      if (role == 'admin') {
        Get.to(const AdminHome());
      } else {
        Get.to(const Home());
      }
      
    }
  }
}
