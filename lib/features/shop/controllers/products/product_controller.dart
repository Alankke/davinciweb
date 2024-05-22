// ignore_for_file: avoid_print

import 'package:davinciweb/data/repositories/shop/product_repository.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  RxList<ProductModel> fetchedProducts = <ProductModel>[].obs;
  final productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }
  
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final products = await productRepository.getProductsFromFirestore();
      return products;
    } catch (error) {
      print('Error fetching products: $error');
      return []; // Devuelve una lista vacía en caso de error
    }
  }

}
