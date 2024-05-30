import 'package:davinciweb/features/authentication/screens/login/login_form.dart';
import 'package:davinciweb/common/widgets/custom_shapes/image_login_signup.dart';
import 'package:davinciweb/features/shop/screens/client/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      
      floatingActionButton: IconButton(onPressed: () => Get.off(() => const Home()), icon: Image.asset('assets/logos/davinciLogoRounded.png', height: 45, width: 45)),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: Center(
            child: isSmallScreen
                //Mobile
                ? const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Logo(),
                      LogInForm(),
                    ],
                  )
                //Desktop
                : Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const Row(
                      children: [
                        Expanded(child: Logo()),
                        Expanded(
                          child: Center(child: LogInForm()),
                        ),
                      ],
                    ),
                  )));
  }
}
