import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/utils/enums/product_categories.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final ProductCategories category;
  String picture;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.category,
      required this.picture});

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Price': price,
      'Category': category,
      'Picture': picture
    };
  }

  static ProductModel emptyProduct() =>
      ProductModel(id: '', name: '', price: 0, category: ProductCategories.noCategory, picture: '');

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductModel(
        id: document.id,
        name: data['Name'] ?? '',
        price: data['Price'] ?? '',
        category: data['Category'] ?? '',
        picture: data['Picture'] ?? '',
      );
    } else {
      return emptyProduct();
    }
  }
}
