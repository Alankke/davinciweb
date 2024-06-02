import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  _PaymentMethodSectionState createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecciona el método para pagar tu compra',
        ),
        const SizedBox(height: DaVinciSizes.spaceBtwItems),
        _buildPaymentOption(context, 'Efectivo', Icons.attach_money),
        _buildPaymentOption(context, 'Transferencia Bancaria', Icons.account_balance),
        _buildPaymentOption(context, 'Tarjeta de Crédito/Débito', Icons.credit_card),
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
      child: RadioListTile<String>(
        title: Row(
          children: [
            Icon(icon),
            const SizedBox(width: DaVinciSizes.sm),
            Text(title),
          ],
        ),
        value: title,
        groupValue: _selectedPaymentMethod,
        onChanged: (value) {
          setState(() {
            _selectedPaymentMethod = value;
          });
          _showPaymentDialog(context, title);
        },
      ),
    );
  }

  void _showPaymentDialog(BuildContext context, String paymentMethod) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Método de Pago: $paymentMethod'),
        content: Text('Has seleccionado $paymentMethod como método de pago.'),
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
}