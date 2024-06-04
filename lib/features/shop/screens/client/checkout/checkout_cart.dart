import 'package:davinciweb/features/shop/controllers/cart/cart_controller.dart';
import 'package:davinciweb/features/shop/controllers/cart/checkout_controller.dart';
import 'package:davinciweb/features/shop/screens/client/checkout/payment_method.dart';
import 'package:davinciweb/features/shop/screens/client/checkout/user_info.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:davinciweb/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutCart extends StatelessWidget {
  CheckoutCart({super.key});
  final cartController = Get.find<CartController>();
  final checkoutController = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(100, 50, 100, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Text('Procesar compra', style: DaVinciTextStyles.cartInfoLg)),
                  const Divider(color: DaVinciColors.black, thickness: 2),
                  const SizedBox(height: DaVinciSizes.md),
                  UserInfoSection(),
                  const SizedBox(height: DaVinciSizes.md),
                  const PaymentMethodSection()
                ],              
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: DaVinciColors.lightContainer,
              child: Column(
                children: [
                  Obx(() {
                    return Column(
                      children: cartController.cartItems.map((product) {
                        return ListTile(
                          leading: Image.network(product.picture, width: 50, height: 50),
                          title: Text(product.name),
                          subtitle: Text(DaVinciFormatter.formatCurrency(product.price)),
                        );
                      }).toList(),
                    );
                  }),
                  const SizedBox(height: DaVinciSizes.spaceBtwItems),
                  Obx(() {
                    double total = cartController.sumTotal();
                    return Text(
                      'Total: ${DaVinciFormatter.formatCurrency(total)}',
                      style: DaVinciTextStyles.detailsMd
                    );
                  }),
                  const SizedBox(height: DaVinciSizes.spaceBtwItems),
                  ElevatedButton(
                    onPressed: () {
                      if (checkoutController.selectedPaymentMethod.value == null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Debe seleccionar un método de pago antes de finalizar la compra.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Llamar a un método que cree y registre una nueva venta en Firestore
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Procesar Pago'),
                            content: const Text('Tu pago ha sido procesado exitosamente.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text('Pagar'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}