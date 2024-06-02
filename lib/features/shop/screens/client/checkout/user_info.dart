import 'package:davinciweb/data/repositories/user/user_repository.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoSection extends StatelessWidget {
  UserInfoSection({super.key});
  final userRepository = Get.put(UserRepository());

  @override
  Widget build(BuildContext context) {
    userRepository.fetchUserDetails();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Información del Usuario',
          style: DaVinciTextStyles.cartInfoLg,
        ),
        Obx(() {
          final user = userRepository.user;
          return Text('Nombre: ${user.name}');
        }),
        Obx(() {
          final user = userRepository.user;
          return Text('Nombre de usuario: ${user.username}');
        }),
        Obx(() {
          final user = userRepository.user;
          return Text('Email: ${user.email}');
        })
      ],
    );
  }
}