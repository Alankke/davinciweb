import 'package:davinciweb/features/shop/controllers/sale/sale_controller.dart';
import 'package:davinciweb/utils/constants/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  //Credit Card
  final cardNumbers = TextEditingController();
  final cardName = TextEditingController();
  final cardCvv = TextEditingController();
  final cardExpiryDate = TextEditingController();
  GlobalKey<FormState> cardKey = GlobalKey<FormState>();

  //Payment Method
  var selectedPaymentMethod = Rx<String?>(null);

  //Sale
  final saleController = Get.put(SaleController());

  void setSelectedPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void createSale(String userId, List<Map<String, dynamic>> products, double totalAmount) async {
    if(selectedPaymentMethod.value != null){
      saleController.createSale(userId, products, totalAmount, selectedPaymentMethod.value!);
    } else {
      DaVinciSnackBars.warning('Por favor seleccione un método de pago');
    }
  }
}
