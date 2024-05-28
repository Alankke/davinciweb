import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs;

  void addToCart(ProductModel product){
    cartItems.add(product);
  }

  void removeFromCart(ProductModel product){
    cartItems.remove(product);
  }
}