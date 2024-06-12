import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davinciweb/data/repositories/shop/product_repository.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final productRepository = Get.put(ProductRepository());

  // Controla el estado de la carga (Renderizado)
  final isLoading = false.obs;
  final hasMoreProducts = true.obs;

  // Número de productos por lote (Renderizado)
  final int productsPerPage = 12;
  DocumentSnapshot? lastProductDocument;

  //Filtrado
  final selectedCategory = ''.obs;

  @override
  void onInit() {
    fetchInitialProducts();
    super.onInit();
  }
  
  //Método para traer inicialmente 12 productos
  //(para llenar una grilla de 4x3 y para administración de productos)
  Future<void> fetchInitialProducts({String category = ''}) async {
    try {
      isLoading.value = true;
      final result = await productRepository.getProductsFromFirestore(
          limit: productsPerPage, category: category);
      products.assignAll(result.products);
      lastProductDocument = result.lastDocument;
      hasMoreProducts.value = result.products.length == productsPerPage;
    } catch (error) {
      throw 'Hubo un error al traer los productos $error';
    } finally {
      isLoading.value = false;
    }
  }

  //Método para traer mas productos desde la base de datos
  //(para grilla de 4x3 y para administración de productos)
  Future<void> fetchMoreProducts() async {
    if (isLoading.value || !hasMoreProducts.value) return;

    try {
      isLoading.value = true;
      final result = await productRepository.getProductsFromFirestore(
          limit: productsPerPage, startAfter: lastProductDocument, category: selectedCategory.value);
      products.addAll(result.products);
      lastProductDocument = result.lastDocument;
      hasMoreProducts.value = result.products.length == productsPerPage;
    } catch (error) {
      throw 'Hubo un error al intentar traer mas productos $error';
    } finally {
      isLoading.value = false;
    }
  }
  
  void setCategory (String category){
    selectedCategory.value = category;
    fetchInitialProducts(category: category);
  }

  //Eliminar producto de firestore
  Future<void> deleteProduct(String productId) async {
    try {
      await productRepository.deleteProduct(productId);
      products.removeWhere((product) => product.id == productId);
    } catch (error) {
      throw 'Hubo un error al eliminar el producto $error';
    }
  }
}

class PaginatedProducts {
  final List<ProductModel> products;
  final DocumentSnapshot? lastDocument;

  PaginatedProducts(this.products, this.lastDocument);
}
