import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/features/shop/screens/home/admin_home.dart';
import 'package:davinciweb/features/shop/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  static AuthService get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> checkUserType() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot docSnapshot =
          await _db.collection('users').doc(user.uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        String userType = data['Role'];
        if (userType == 'admin') {
          Get.offAll(() => const AdminHome());
        } else {
          Get.offAll(() => const Home());
        }
      }
    }
  }
}
