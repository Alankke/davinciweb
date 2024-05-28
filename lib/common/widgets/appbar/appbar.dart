import 'package:davinciweb/features/authentication/controllers/login/login_controller.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:davinciweb/common/widgets/custom_shapes/header.dart';
import 'package:davinciweb/features/authentication/screens/login/login.dart';
import 'package:davinciweb/features/authentication/screens/signup/signup.dart';
import 'package:davinciweb/features/shop/screens/client/home.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppBar({super.key});

  final loginController = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
  
  List<Widget> loggedIn = [
      IconButton(
          icon: const Icon(Icons.shopping_cart, color: DaVinciColors.textWhite,),
          onPressed: () {
            // Navegar a la página del carrito de compras
          },
        ),
        TextButton(
          child: const Text('Cerrar Sesión', style: DaVinciTextStyles.appBarTextStyleMd),
          onPressed: () => loginController.logout(),
        ),
    ];

    List<Widget> loggedOut = [
      TextButton(
        onPressed: () => Get.to(const LogIn()),
        child: const Text('Iniciar sesión', style: DaVinciTextStyles.appBarTextStyleMd),
      ),
      TextButton(
        onPressed: () => Get.to(const SignUp()),
        child: const Text('Crear cuenta', style: DaVinciTextStyles.appBarTextStyleMd),
      ),
    ];

    return AppBar(
      backgroundColor: DaVinciColors.midnight,
      automaticallyImplyLeading: false,
      flexibleSpace: const Header(),
      leading: IconButton(onPressed: () => Get.off(() => const Home()), icon: Image.asset('assets/logos/davinciLogoRounded.png', height: 45, width: 45)),
      actions: loginController.isLoggedIn.value ? loggedIn : loggedOut,
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
                    onPressed: () => Get.to(const Home()), //Llevar al footer
                    child: const Text('Medios de pago',
                        style: DaVinciTextStyles.appBarTextStyleSm))
              ],
            ),
          )),
    );
  }


  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(200);
}