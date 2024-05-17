import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/utils/enums/product_categories.dart';

class ProductModel {
  final String id;
  String name;
  double price;
  ProductCategory category;
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

  static ProductModel emptyProduct() => ProductModel(
      id: '',
      name: '',
      price: 0,
      category: ProductCategory.noCategory,
      picture: '');

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    if (document.data() != null) {
      return ProductModel(
        id: document.id,
        name: data['Name'] ?? '',
        price: double.parse((data['Price'] ?? 0.0).toString()),
        category: data['Category'] ?? ProductCategory.noCategory,
        picture: data['Picture'] ?? '',
      );
    } else {
      return ProductModel.emptyProduct();
    }
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        name: json['Name'],
        price: json['Price'].toDouble(),
        // ignore: prefer_interpolation_to_compose_strings
        category: ProductCategory.values.firstWhere((element) =>
            element.toString() == 'ProductCategory.' + json['Category']),
        picture: json['Picture']);
  }
}
