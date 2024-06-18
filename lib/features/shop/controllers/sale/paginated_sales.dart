import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/features/shop/models/sale_model.dart';

class PaginatedSales {
  PaginatedSales(this.sales, this.lastDocument);

  final List<SaleModel> sales;
  final DocumentSnapshot? lastDocument;  
}