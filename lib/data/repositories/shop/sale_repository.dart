// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/features/shop/models/sale_model.dart';
import 'package:get/get.dart';

class SaleRepository {
  static SaleRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveSaleRecord(Map<String, dynamic> json,) async {
    try {
      await _db.collection('Sales').add(json);
    } catch (error) {
      throw 'Hubieron problemas al intentar registrar una venta en Firestore: $error';
    }
  }

    Future<List<SaleModel>> getSalesFromFirestore() async {
    try {
      final querySnapshot = await _db.collection('Sales').get();
      final products = querySnapshot.docs
          .map((doc) => SaleModel.fromSnapshot(doc))
          .toList();
      return products;
    } catch (error) {
      print('Error trayendo ventas desde Firestore: $error');
      return []; // Devuelve una lista vacía en caso de error
    }
  }
}
