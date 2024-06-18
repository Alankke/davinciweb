import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/features/shop/controllers/product/paginated_products.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Create
  //Método para crear producto y guardarlo en firestore
  Future<void> saveProductRecord(Map<String, dynamic> json) async {
    try {
      await _db.collection("Products").add(json);
    } catch (e) {
      throw 'Hubieron errores en la creación del producto $e';
    }
  }

  //Create
  //Función para subir la imagen a firebase storage
  Future<String> uploadImage(String path, XFile image) async {
    try {
      //Obtiene la referencia de la imagen en storage
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      //La transforma a bytes
      Uint8List data = await image.readAsBytes();
      await ref.putData(data);
      return await ref.getDownloadURL();
    } catch (e) {
      throw 'Hubieron errores en la subida de imagen a firestore: $e';
    }
  }

  //Read
  //Función para leer los productos desde firestore y paginarlos con un limite
  Future<PaginatedProducts> getProductsFromFirestore(
    {int limit = 12, DocumentSnapshot? startAfter, String category = ''}) async {
    try {
        //Obtiene primero 12 productos
      Query query = _db.collection("Products").limit(limit);
        //Si el usuario quiere filtrar por categoría filtra por categoría
      if (category.isNotEmpty) {
        //Realiza el filtrado de categoría
        query = query.where('Category', isEqualTo: category);
        //Si hay que cargar mas productos, los carga luego del documento especificado con startAfter
      } else if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
        //Se ejecuta finalmente la consulta
      final querySnapshot = await query.get();
        //Mapea toda la data traída de firestore una por una a un ProductModel 
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc as QueryDocumentSnapshot<Map<String, dynamic>>))
          .toList();
        //Se retorna un PaginatedProducts con la lista de productos traídos y el ultimo producto para usar en la futura paginación
      return PaginatedProducts(
        products,
        querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
      );
    } catch (error) {
      return PaginatedProducts([], null);
    }
  }

  //Update
  //Método para actualizar un solo campo del producto y guardarlo en firestore
  Future<void> updateSingleField(
      Map<String, dynamic> json, String productId) async {
    try {
      //Actualiza el documento del producto con el json
      await _db.collection("Products").doc(productId).update(json);
    } catch (e) {
      throw 'Hubieron errores en la actualización de campos en firestore: $e';
    }
  }

  //Delete
  //Eliminar el producto de firestore
  Future<void> deleteProduct(String productId) async {
    try {
      await _db.collection("Products").doc(productId).delete();
    } catch (e) {
      throw 'Hubo un error al eliminar el producto $e';
    }
  }
}
