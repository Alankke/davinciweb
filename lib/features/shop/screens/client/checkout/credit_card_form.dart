import 'package:davinciweb/features/shop/controllers/cart/checkout_controller.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:davinciweb/utils/formatters/formatter.dart';
import 'package:davinciweb/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreditCardForm extends StatelessWidget {
  const CreditCardForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());

    return Form(
      key: controller.cardKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ingresa los datos de tu tarjeta:'),
          const SizedBox(height: DaVinciSizes.spaceBtwItems / 2),
          TextFormField(
            controller: controller.cardName,
            validator: (value) =>
                DaVinciValidator.validateEmptyText('Nombre del titular', value),
            decoration: const InputDecoration(
              labelText: 'Nombre del Titular',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: DaVinciSizes.spaceBtwItems / 2),
          TextFormField(
            controller: controller.cardNumbers,
            validator: (value) => DaVinciValidator.validateCardNumber(value),
            decoration: const InputDecoration(
              labelText: 'Número de la Tarjeta',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: DaVinciSizes.spaceBtwItems / 2),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.cardExpiryDate,
                  validator: (value) =>
                      DaVinciValidator.validateExpiryDate(value),
                  decoration: const InputDecoration(
                    labelText: 'Vencimiento (MM/AA)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    _ExpiryDateInputFormatter(),
                  ],
                ),
              ),
              const SizedBox(width: DaVinciSizes.sm),
              Expanded(
                child: TextFormField(
                  controller: controller.cardCvv,
                  validator: (value) => DaVinciValidator.validateCvv(value),
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: DaVinciSizes.spaceBtwItems / 2),
          Center(
            child: TextButton(
              onPressed: () {
                if (controller.cardKey.currentState!.validate()) {
                  // Lógica para procesar el pago con tarjeta
                } else {
                  // El formulario contiene errores, no se procesa el pago
                }
              },
              child: const Text('Procesar Pago'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    // Eliminamos cualquier carácter no numérico
    final numericText = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Insertamos '/' solo si la longitud del texto es 4 y si son números
    if (numericText.length == 4) {
      final formattedText = DaVinciFormatter.formatExpiryDate(numericText);
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }

    // Devolvemos el valor nuevo si no es necesario formatear
    return newValue.copyWith(
      text: numericText,
      selection: TextSelection.collapsed(offset: numericText.length),
    );
  }
}
