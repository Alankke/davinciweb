import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  _PaymentMethodSectionState createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  final PaymentMethodController paymentMethodController = Get.put(PaymentMethodController());

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
        _buildPaymentOption(context, 'Transferencia Bancaria', Icons.account_balance),
        _buildPaymentOption(context, 'Tarjeta de Crédito/Débito', Icons.credit_card),
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
          groupValue: paymentMethodController.selectedPaymentMethod.value,
          onChanged: (value) {
            paymentMethodController.setSelectedPaymentMethod(value!);
            _buildPaymentDetails(context);
          },
        );
      }),
    );
  }

  void _buildPaymentDetails(BuildContext context) {
    final selectedMethod = paymentMethodController.selectedPaymentMethod.value;
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
        )
      );
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
        )
      );
    } else if (selectedMethod == 'Tarjeta de Crédito/Débito') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Has seleccionado Tarjeta de Crédito/Débito'),
          content: creditCardDetails(),
        )
      );
    } else {
      Container(child: Text('Error'));
    }
  }

  Widget bankTransferDetails() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Información para Transferencia Bancaria:'),
        Text('Razón Social: Empresa Ficticia S.A.'),
        Text('CUIT: 30-12345678-9'),
        Text('CBU: 1234567890123456789012'),
        Text('Alias: EMPRESA.FICTICIA'),
      ],
    );
  }

  Widget creditCardDetails() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ingresa los datos de tu tarjeta:'),
          const SizedBox(height: DaVinciSizes.spaceBtwItems),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nombre del Titular',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: DaVinciSizes.spaceBtwItems),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Número de la Tarjeta',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: DaVinciSizes.spaceBtwItems),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Vencimiento (MM/AA)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: DaVinciSizes.sm),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: DaVinciSizes.spaceBtwItems),
          Center(
            child: TextButton(
              onPressed: () {
                // Lógica para procesar el pago con tarjeta
              },
              child: const Text('Procesar Pago'),
            ),
          ),
        ],
      );
  }
}

class PaymentMethodController extends GetxController {
  var selectedPaymentMethod = Rx<String?>(null);

  void setSelectedPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }
}
