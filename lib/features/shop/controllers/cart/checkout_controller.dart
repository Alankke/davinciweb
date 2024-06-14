import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/data/repositories/shop/sale_repository.dart';
import 'package:davinciweb/features/shop/models/sale_model.dart';
import 'package:davinciweb/utils/constants/snackbars.dart';
import 'package:davinciweb/utils/helpers/helper_functions.dart';
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

  //Lógicas
  final saleRepository = Get.put(SaleRepository());
  final Rx<SaleModel> sale = SaleModel.emptySale().obs;
  final RxString generatedCode = ''.obs; //Variable observada para el código generado

  void setSelectedPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  //Método para crear venta a partir de los datos de pantalla Checkout y guardarla en firestore
  void createSale(String userId, List<Map<String, dynamic>> products, double totalAmount) async {
    try {
      //Llena un SaleModel con los datos ingresados
      String generatedCode = DaVinciHelpersFunctions.generateSaleCode(6);
      SaleModel newSale = SaleModel(
        userId: userId,
        paymentMethod: selectedPaymentMethod.value!,
        state: 'Pendiente',
        generatedCode: generatedCode,
        products: products,
        totalAmount: totalAmount,
        timestamp: Timestamp.now(),
      );
      //Llama a la clase repository para registrar la venta en firestore
      await saleRepository.saveSaleRecord(newSale);
      this.generatedCode.value = generatedCode; //Actualiza el código generado (hasta este momento el código es vacío)
      DaVinciSnackBars.success('Su compra se ha registrado, este es su código para el retiro $generatedCode');
    } catch (e) {
      DaVinciSnackBars.error('Se ha producido un error, intente nuevamente más tarde');
    }
  }
}
