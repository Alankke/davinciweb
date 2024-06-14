import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';

class PaginatedProducts {
  PaginatedProducts(this.products, this.lastDocument);

  final List<ProductModel> products;
  final DocumentSnapshot? lastDocument;  
}