import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/features/shop/controllers/product/product_controller.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Crear producto y guardarlo en firestore
  Future<void> saveProductRecord(Map<String, dynamic> json) async {
    try {
      await _db.collection("Products").add(json);
    } catch (e) {
      throw 'Hubieron errores en la creación del producto $e';
    }
  }

  //Leer los productos desde firestore
     Future<PaginatedProducts> getProductsFromFirestore(
      {int limit = 12, DocumentSnapshot? startAfter, String category = ''}) async {
    try {
      Query query = _db.collection('Products').limit(limit);
      if (category.isNotEmpty) {
        query = query.where('Category', isEqualTo: category);
      } else if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
      final querySnapshot = await query.get();
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc as QueryDocumentSnapshot<Map<String, dynamic>>))
          .toList();
      return PaginatedProducts(
        products,
        querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
      );
    } catch (error) {
      return PaginatedProducts([], null);
    }
  }

  //Subir la imagen a firebase storage
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      Uint8List data = await image.readAsBytes();
      await ref.putData(data);
      return await ref.getDownloadURL();
    } catch (e) {
      throw 'Hubieron errores en la subida de imagen a firestore: $e';
    }
  }

  //Actualizar un solo campo del producto y guardarlo en firestore
  Future<void> updateSingleField(
      Map<String, dynamic> json, String productId) async {
    try {
      await _db.collection("Products").doc(productId).update(json);
    } catch (e) {
      throw 'Hubieron errores en la actualización de campos en firestore: $e';
    }
  }

  //Eliminar el producto de firestore
  Future<void> deleteProduct(String productId) async {
    try {
      await _db.collection("Products").doc(productId).delete();
    } catch (e) {
      throw 'Hubo un error al eliminar el producto $e';
    }
  }
}
