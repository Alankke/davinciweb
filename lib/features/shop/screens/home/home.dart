import 'package:davinciweb/common/styles/text_style.dart';
import 'package:davinciweb/common/widgets/products/card_product.dart';
import 'package:davinciweb/features/shop/controllers/products/product_controller.dart';
import 'package:davinciweb/features/shop/screens/store/custom_grid_view.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(DaVinciSizes.defaultSpace),
              child: Column(
                children: [
                  Obx(() {
                    if (controller.fetchedProducts.isEmpty) {
                      return const Center(
                        child: Text('No se encontraron productos',
                            style: DaVinciTextStyles.headlineLarge),
                      );
                    }
                    return CustomGridView(
                        itemCount: controller.fetchedProducts.length,
                        itemBuilder: (_, index) => ProductCard(
                            product: controller.fetchedProducts[index]));
                  })
                ],
              ),
            )
          ],
        )));
  }
}
