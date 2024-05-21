import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:davinciweb/common/widgets/custom_shapes/circular_container.dart';
import 'package:davinciweb/common/widgets/custom_shapes/circular_image.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //Hacer pantalla de detalles de producto
      onTap:
          () {}, //Cuando el usuario presione en el producto que se le abran los detalles de ese producto
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: DaVinciColors.darkGrey.withOpacity(0.1),
                  blurRadius: 50,
                  spreadRadius: 7,
                  offset: const Offset(0, 2))
            ],
            borderRadius:
                BorderRadius.circular(DaVinciSizes.productImageRadius),
            color: DaVinciColors.white),
        child: Column(
          children: [
            //Imagen
            CircularContainer(
                height: 180,
                padding: const EdgeInsets.all(DaVinciSizes.sm),
                backgroundColor: DaVinciColors.light,
                child: CircularImage(
                    imageUrl: product.picture, applyImageRadius: true)),
            //Detalles
            Padding(
              padding: const EdgeInsets.only(left: DaVinciSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nombre',
                    style: DaVinciTextStyles.detailsMd,
                  ),
                  const SizedBox(height: DaVinciSizes.spaceBtwItems / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('\$00.0',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: DaVinciTextStyles.headlineMedium),
                      Container(
                        decoration: const BoxDecoration(
                            color: DaVinciColors.dark,
                            borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(DaVinciSizes.cardRadiusMd),
                                bottomRight: Radius.circular(
                                    DaVinciSizes.cardRadiusLg))),
                        child: const SizedBox(
                            width: DaVinciSizes.iconLg * 1.2,
                            height: DaVinciSizes.iconLg * 1.2,
                            child: Center(
                                child: Icon(Icons.add,
                                    color: DaVinciColors.white))),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
