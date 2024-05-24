import 'package:davinciweb/data/services/user.dart';
import 'package:davinciweb/features/shop/screens/home/admin_home.dart';
import 'package:davinciweb/features/shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = Get.put(UserService());
    return GetMaterialApp(
      title: 'Da Vinci Web',
      home: FutureBuilder<String?>(
        future: userService.getUserRole(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == 'admin') {
            return const AdminHome();
          } else {
            return const Home();
          }
        },
      ),
    );
  }
}
