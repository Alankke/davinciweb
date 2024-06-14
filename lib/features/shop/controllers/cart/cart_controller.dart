import 'package:davinciweb/common/widgets/products/cart.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController with GetSingleTickerProviderStateMixin{
  static CartController get instance => Get.find();
  var cartItems = <ProductModel>[].obs;
  var isCartVisible = false.obs;

  OverlayEntry? cartOverlayEntry;
  late AnimationController animationController;
  late Animation<Offset> animation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void addToCart(ProductModel product){
    cartItems.add(product);
  }

  void removeFromCart(ProductModel product){
    cartItems.remove(product);
  }

  double sumTotal(){
    double total = 0.00;
    for (var cartItem in cartItems) {      
      total += cartItem.price; 
    }
    return total;
  }

  //Método para realizar la animación del carrito y colocar un Overlay (capa por encima de otra capa) en la pantalla actual 
  void toggleCartVisibility(BuildContext context) {
    if (cartOverlayEntry == null) {
      cartOverlayEntry = createCartOverlayEntry(context);
      Overlay.of(context).insert(cartOverlayEntry!);
    }
    if (isCartVisible.value) {
      animationController.reverse().then((_) {
        isCartVisible.value = false;
        cartOverlayEntry?.remove();
        cartOverlayEntry = null;
      });
    } else {
      isCartVisible.value = true;
      animationController.forward();
    }
  }
  
  //Función para crear el overlay
  OverlayEntry createCartOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        right: 0,
        child: SlideTransition(
          position: animation,
          child: const SlideInCart(),
        ),
      ),
    );
  }
}
