import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/features/shop/controllers/sale/paginated_sales.dart';
import 'package:davinciweb/features/shop/models/sale_model.dart';
import 'package:get/get.dart';

class SaleRepository {
  static SaleRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  //Create
  //Crear venta y guardarla en firestore
  Future<void> saveSaleRecord(Map<String, dynamic> json) async {
    try {
      await _db.collection("Sales").add(json);
    } catch (error) {
      throw 'Hubieron problemas al intentar registrar una venta en Firestore: $error';
    }
  }

  //Read
  //Leer las ventas desde firestore
  Future<PaginatedSales> getSalesFromFirestore({int limit = 12, DocumentSnapshot? startAfter,}) async{
    try {
      
      Query query = _db.collection("Sales").limit(limit);

      if(startAfter != null){
        query = query.startAfterDocument(startAfter);
      }

      final querySnapshot = await query.get();
      final sales = querySnapshot.docs
          .map((doc) => SaleModel.fromSnapshot(doc as QueryDocumentSnapshot<Map<String, dynamic>>))
          .toList();
    
    return PaginatedSales(
      sales,
      querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
    );
    } catch (error) {
      return PaginatedSales([], null);
    }
  }

  //Update
  //Actualizar un campo de la venta y guardarla en firestore
  Future<void> updateSingleField(
      Map<String, dynamic> json, String saleId) async {
    try {
      //Actualiza el documento de la venta con el json
      await _db.collection("Sales").doc(saleId).update(json);
    } catch (e) {
      throw 'Hubieron errores en la actualización de campos de venta en firestore: $e';
    }
  }

  //Delete
  //Eliminar la venta de firestore
  Future<void> deleteSale(String saleId) async {
    try {
      await _db.collection("Sales").doc(saleId).delete();
    } catch (e) {
      throw 'Hubo un error al eliminar la venta $e';
    }
  }  
}
