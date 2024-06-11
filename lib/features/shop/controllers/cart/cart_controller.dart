import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs;
  var isCartVisible = false.obs;

  void addToCart(ProductModel product){
    cartItems.add(product);
  }

  void removeFromCart(ProductModel product){
    cartItems.remove(product);
  }

  void toggleCartVisibility() {
    isCartVisible.value = !isCartVisible.value;
  }

  double sumTotal(){
    double total = 0.00;
    for (var cartItem in cartItems) {      
      total += cartItem.price; 
    }
    return total;
  } 
}
