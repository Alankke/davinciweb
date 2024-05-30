import 'package:davinciweb/common/widgets/products/cart.dart';
import 'package:davinciweb/features/authentication/controllers/login/login_controller.dart';
import 'package:davinciweb/features/shop/controllers/cart_controller.dart';
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
  final cartController = Get.put(CartController());
  OverlayEntry? cartOverlayEntry;
  final cart = SlideInCart();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: DaVinciColors.midnight,
      automaticallyImplyLeading: false,
      flexibleSpace: const Header(),
      leading: IconButton(onPressed: () => Get.off(() => const Home()), icon: Image.asset('assets/logos/davinciLogoRounded.png', height: 45, width: 45)),
      actions: loginController.isLoggedIn.value ? _buildLoggedInActions(context) : _buildLoggedOutActions(context),
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

  //Acciones para el usuario logueado
  List<Widget> _buildLoggedInActions(BuildContext context) {
    return [
      Row(
        children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: DaVinciColors.textWhite),
            onPressed: () {
              toggleCartOverlay(context);
            },
          ),
          Obx(() {
            return Text('${cartController.cartItems.length}', style: const TextStyle(color: DaVinciColors.textWhite));
          }),
        ],
      ),
      TextButton(
        child: const Text('Cerrar Sesión', style: DaVinciTextStyles.appBarTextStyleMd),
        onPressed: () => loginController.logout(),
      ),
    ];
  }

  //Acciones para el usuario no logueado
  List<Widget> _buildLoggedOutActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => Get.to(const LogIn()),
        child: const Text('Iniciar sesión', style: DaVinciTextStyles.appBarTextStyleMd),
      ),
      TextButton(
        onPressed: () => Get.to(const SignUp()),
        child: const Text('Crear cuenta', style: DaVinciTextStyles.appBarTextStyleMd),
      ),
      IconButton(
        icon: const Icon(Icons.shopping_cart, color: DaVinciColors.textWhite),
        onPressed: () {
          toggleCartOverlay(context);
        },
      ),
    ];
  }

  //Animación de carrito de compras
  void toggleCartOverlay(BuildContext context) {
    if (cartOverlayEntry == null) {
      cartOverlayEntry = createCartOverlayEntry(context);
      Overlay.of(context)?.insert(cartOverlayEntry!);
    }
    cartController.toggleCartVisibility();
  }

     OverlayEntry createCartOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        right: 0,
        child: SlideInCart(),
      ),
    );
  }


  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(200);
}