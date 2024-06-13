import 'package:davinciweb/features/authentication/controllers/login/login_controller.dart';
import 'package:davinciweb/features/shop/screens/client/checkout/checkout_cart.dart';
import 'package:davinciweb/utils/constants/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davinciweb/features/shop/controllers/cart/cart_controller.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:davinciweb/utils/formatters/formatter.dart';

class SlideInCart extends StatelessWidget {
  const SlideInCart({super.key,});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final LogInController loginController = Get.find<LogInController>();

    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.30,
        height: MediaQuery.of(context).size.height,
        color: DaVinciColors.lightContainer,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close, color: DaVinciColors.error),
                  onPressed: () {
                    cartController.toggleCartVisibility(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    ProductModel product = cartController.cartItems[index];
                    return ListTile(
                      leading: Image.network(product.picture, width: 50, height: 50),
                      title: Text(product.name),
                      subtitle: Text(DaVinciFormatter.formatCurrency(product.price)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: DaVinciColors.error),
                        onPressed: () {
                          cartController.removeFromCart(product);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.all(16.0),
              child: Column(
                children: [
                  Obx(() {
                    double total = cartController.sumTotal();
                    return Text(
                      'Total: ${DaVinciFormatter.formatCurrency(total)}',
                      style: DaVinciTextStyles.footerTitle,
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  cartController.toggleCartVisibility(context);
                  loginController.isLoggedIn.value 
                    ? Get.to(() => CheckoutCart()) 
                    : DaVinciSnackBars.warning('Debe iniciar sesión antes de finalizar su compra');                    
                },
                child: const Text('Finalizar compra'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
