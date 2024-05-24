import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:flutter/material.dart';

// Widget ProductCard
class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Lógica para cuando se presione la tarjeta de producto
      },
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
            '\$${product.price.toStringAsFixed(2)}',
            style: DaVinciTextStyles.detailsMd,
          )
        ],
      )
    );
  }
}