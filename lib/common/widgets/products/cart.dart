import 'package:davinciweb/features/shop/controllers/products/cart_controller.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:davinciweb/features/shop/screens/client/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart {
  final cartController = Get.put(CartController());

  void showCartDialog(BuildContext context, List<ProductModel> products){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Carrito de compras'),
                const SizedBox(height: 20.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index){
                    ProductModel product = products[index];
                    return ListTile(
                      leading: Image.network(product.picture, width: 50, height: 50),
                      title: Text(product.name),
                      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    );
                  }                  
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(onPressed: () => Get.to(const Home()), child: const Text('Finalizar compra'))
              ],
            ),
          ),
        );
      }
    );
  }
}