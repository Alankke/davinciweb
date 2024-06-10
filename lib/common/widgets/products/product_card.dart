import 'package:davinciweb/features/shop/controllers/cart/cart_controller.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:davinciweb/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Widget ProductCard
class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                product.picture,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(product.name, style: DaVinciTextStyles.detailsMd,),
          Text(
            DaVinciFormatter.formatCurrency(product.price),
            style: DaVinciTextStyles.detailsMd,
          ),
          ElevatedButton(
            onPressed: () => cartController.addToCart(product),
            child: const Text('Agregar al carrito')
          )
        ],
      )
    );
  }
}