import 'package:davinciweb/features/shop/screens/client/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Óptica Da Vinci',
      home: Home()
    );
  }
}
