import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditCardController extends GetxController {
  static CreditCardController get instance => Get.find();

  //Form
  final numbers = TextEditingController();
  final name = TextEditingController();
  final cvv = TextEditingController();
  final expiryDate = TextEditingController();

  //Lógicas
  GlobalKey<FormState> creditCardKey = GlobalKey<FormState>();
}