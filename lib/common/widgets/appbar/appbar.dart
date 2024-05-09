import 'package:davinciweb/common/styles/text_style.dart';
import 'package:davinciweb/common/widgets/custom_shapes/header.dart';
import 'package:davinciweb/features/authentication/screens/login/login.dart';
import 'package:davinciweb/features/authentication/screens/signup/signup.dart';
import 'package:davinciweb/features/shop/screens/home/home.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: DaVinciColors.midnight,
        automaticallyImplyLeading: false,
        flexibleSpace: const Header(),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: DaVinciColors.light)),
        actions: <Widget>[
          //Iniciar Sesión
          TextButton(
              onPressed: () => Get.to(const LogIn()),
              child: const Text('Iniciar sesión',
                  style: DaVinciTextStyles.appBarTextStyleMd)),
          //Crear cuenta
          TextButton(
              onPressed: () => Get.to(const SignUp()),
              child: const Text('Crear cuenta',
                  style: DaVinciTextStyles.appBarTextStyleMd)),
        ],
        bottom: PreferredSize(
          preferredSize: preferredSize,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DaVinciSizes.md),
            //Botones
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Contacto
                TextButton(
                    onPressed: () => Get.to(const Home()), //Llevar al footer
                    child: const Text('Contacto',
                        style: DaVinciTextStyles.appBarTextStyleSm)),
                //Productos
                DropdownButton<String>(
                  items: <String>[
                    'Lentes de contacto',
                    'Anteojos de sol',
                    'Anteojos de receta',
                    'Accesorios'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                  hint: const Text('Productos',
                      style: DaVinciTextStyles.appBarTextStyleSm),
                ),
                //Medios
                TextButton(
                    onPressed: () =>
                        Get.to(const Home()), //Llevar a los medios de pago
                    child: const Text('Medios de pago',
                        style: DaVinciTextStyles.appBarTextStyleSm))
              ],
            ),
          )
        ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(200);
}
