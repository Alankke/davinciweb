import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/data/repositories/shop/sale_repository.dart';
import 'package:davinciweb/features/shop/models/sale_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController{
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
  GlobalKey<FormState> checkoutKey = GlobalKey<FormState>();

  void setSelectedPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  String generateSaleCode(int length){
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  void createSale(String userId, List<Map<String, dynamic>> products, double totalAmount) async {
    try {
      if(checkoutKey.currentState != null && checkoutKey.currentState!.validate()){
        String generatedCode = generateSaleCode(6);

        SaleModel newSale = SaleModel(
          id: FirebaseFirestore.instance.collection('Sales').doc().id,
          userId: userId,
          products: products,
          totalAmount: totalAmount,
          paymentMethod: selectedPaymentMethod.value!,
          generatedCode: generatedCode,
          state: 'Pendiente',
          timestamp: Timestamp.now()
        );
      }
    } catch (e) {
      
    }
  }
}