import 'package:davinciweb/data/repositories/user/user_repository.dart';
import 'package:davinciweb/features/shop/controllers/cart/cart_controller.dart';
import 'package:davinciweb/features/shop/controllers/cart/checkout_controller.dart';
import 'package:davinciweb/features/shop/screens/client/checkout/payment_method.dart';
import 'package:davinciweb/features/shop/screens/client/checkout/user_info.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:davinciweb/utils/constants/snackbars.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:davinciweb/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutCart extends StatelessWidget {
  CheckoutCart({super.key});
  final cartController = Get.find<CartController>();
  final checkoutController = Get.put(CheckoutController());
  final userRepository = Get.put(UserRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, 
        backgroundColor: DaVinciColors.midnight, 
        foregroundColor: DaVinciColors.light,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Columna detalles
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
                  const PaymentMethodSection(),
                  const SizedBox(height: DaVinciSizes.md),
                  // Mostrar el código generado si está disponible
                  Obx(() {
                    if (checkoutController.generatedCode.isNotEmpty) {
                      return Column(
                        children: [
                          const Divider(color: DaVinciColors.black, thickness: 2),
                          Text(
                            'Código para retiro: ${checkoutController.generatedCode.value}',
                            style: DaVinciTextStyles.detailsMd,
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
                ],
              ),
            ),
          ),
          // Columna carrito
          Expanded(
            flex: 1,
            child: Container(
              color: DaVinciColors.lightContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                    ],
                  ),
                  const SizedBox(height: DaVinciSizes.spaceBtwItems),
                  Padding(
                    padding: const EdgeInsets.all(DaVinciSizes.sm),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Divider(color: DaVinciColors.black, thickness: 2),
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
                              DaVinciSnackBars.warning('Debes seleccionar un método de pago antes de finalizar la compra');
                            } else if(checkoutController.generatedCode.isEmpty){
                              final products = cartController.cartItems.map((product) => {
                                'name': product.name,
                                'price': product.price,
                              }).toList();
                        
                              double totalAmount = cartController.sumTotal();
                              String userId = userRepository.user.id;
                              checkoutController.createSale(userId, products, totalAmount);
                            } else{
                              DaVinciSnackBars.info('Su venta ya se ha registrado');
                            }
                          },
                          child: const Text('Finalizar compra'),
                        ),
                      ],
                    ),
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
