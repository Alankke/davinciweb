// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Create
  Future<void> saveProductRecord(Map<String, dynamic> json) async {
    try {
      await _db.collection("Products").add(json);
    } catch (e) {
      throw 'Hubieron errores en la creación del producto $e';
    }
  }

  //Read
  Future<List<ProductModel>> getProductsFromFirestore() async {
    try {
      final querySnapshot = await _db.collection('Products').get();
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } catch (error) {
      print('Error fetching products from Firestore: $error');
      return []; // Devuelve una lista vacía en caso de error
    }
  }

  //Update
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      Uint8List data = await image.readAsBytes();
      await ref.putData(data);
      return await ref.getDownloadURL();
    } catch (e) {
      throw 'Hubieron errores en la subida de imagen $e';
    }
  }

  //Update
  Future<void> updateSingleField(
      Map<String, dynamic> json, String productId) async {
    try {
      await _db.collection("Products").doc().update(json);
    } catch (e) {
      throw 'Hubieron errores en la actualización de campos $e';
    }
  }
}
