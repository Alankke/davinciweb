import 'package:davinciweb/features/shop/controllers/cart/checkout_controller.dart';
import 'package:davinciweb/features/shop/screens/client/checkout/credit_card_form.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  final controller =
      Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecciona el método para pagar tu compra',
          style: DaVinciTextStyles.cartInfoLg,
        ),
        const SizedBox(height: DaVinciSizes.spaceBtwItems),
        _buildPaymentOption(context, 'Efectivo', Icons.attach_money),
        _buildPaymentOption(
            context, 'Transferencia Bancaria', Icons.account_balance),
        _buildPaymentOption(
            context, 'Tarjeta de Crédito/Débito', Icons.credit_card),
        const SizedBox(height: DaVinciSizes.spaceBtwItems)
      ],
    );
  }

  Widget _buildPaymentOption(BuildContext context, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: DaVinciSizes.xs),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Obx(() {
        return RadioListTile<String>(
          title: Row(
            children: [
              Icon(icon),
              const SizedBox(width: DaVinciSizes.sm),
              Text(title),
            ],
          ),
          value: title,
          groupValue: controller.selectedPaymentMethod.value,
          onChanged: (value) {
            controller.setSelectedPaymentMethod(value!);
            _buildPaymentDetails(context);
          },
        );
      }),
    );
  }

  void _buildPaymentDetails(BuildContext context) {
    final selectedMethod = controller.selectedPaymentMethod.value;
    if (selectedMethod == 'Efectivo') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Has seleccionado efectivo'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ));
    } else if (selectedMethod == 'Transferencia Bancaria') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Has seleccionado Transferencia bancaria'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
                content: bankTransferDetails(),
              ));
    } else if (selectedMethod == 'Tarjeta de Crédito/Débito') {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: const Text('Has seleccionado Tarjeta de Crédito/Débito'),
                content: const CreditCardForm(),
              ));
    } else {
      const Text('Error');
    }
  }

  Widget bankTransferDetails() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Información para Transferencia Bancaria:'),
        Text('Razón Social: Empresa Ficticia S.A.'),
        Text('CUIT: 30-12345678-9'),
        Text('CBU: 1234567890123456789012'),
        Text('Alias: EMPRESA.FICTICIA'),
      ],
    );
  }
}
