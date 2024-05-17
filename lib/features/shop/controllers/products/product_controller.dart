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

  void fetchProducts() async {
    try {
      final products = await productRepository.getProducts();

      fetchedProducts.assignAll(products);
    } catch (e) {
      throw 'Error';
    } finally {}
  }
}
