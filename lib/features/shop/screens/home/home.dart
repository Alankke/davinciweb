import 'package:davinciweb/common/styles/text_style.dart';
import 'package:davinciweb/common/widgets/appbar/appbar.dart';
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
        appBar: const HomeAppBar(),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    if (controller.fetchedProducts.isEmpty) {
                      return const Center(
                        child: Text('No se encontraron productos',
                            style: DaVinciTextStyles.homeLarge,
                            ),
                      );
                    }
                    return CustomGridView(
                        itemCount: controller.fetchedProducts.length,
                        itemBuilder: (_, index) => ProductCard(
                            product: controller.fetchedProducts[index]));
                  })
                ],
              )),
        ));
  }
}
