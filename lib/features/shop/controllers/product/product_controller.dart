import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/data/repositories/shop/product_repository.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final productRepository = Get.put(ProductRepository());

  // Controla el estado de la carga
  final isLoading = false.obs;
  final hasMoreProducts = true.obs;

  // Número de productos por lote
  final int productsPerPage = 12;
  DocumentSnapshot? lastProductDocument;

  @override
  void onInit() {
    fetchInitialProducts();
    super.onInit();
  }

  Future<void> fetchInitialProducts() async {
    try {
      isLoading.value = true;
      final result = await productRepository.getProductsFromFirestore(
          limit: productsPerPage);
      products.assignAll(result.products);
      lastProductDocument = result.lastDocument;
      hasMoreProducts.value = result.products.length == productsPerPage;
    } catch (error) {
      print('Error fetching products: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMoreProducts() async {
    if (isLoading.value || !hasMoreProducts.value) return;

    try {
      isLoading.value = true;
      final result = await productRepository.getProductsFromFirestore(
          limit: productsPerPage, startAfter: lastProductDocument);
      products.addAll(result.products);
      lastProductDocument = result.lastDocument;
      hasMoreProducts.value = result.products.length == productsPerPage;
    } catch (error) {
      print('Error fetching more products: $error');
    } finally {
      isLoading.value = false;
    }
  }
}

class PaginatedProducts {
  final List<ProductModel> products;
  final DocumentSnapshot? lastDocument;

  PaginatedProducts(this.products, this.lastDocument);
}
