import 'package:davinciweb/common/widgets/appbar/appbar.dart';
import 'package:davinciweb/common/widgets/custom_shapes/footer.dart';
import 'package:davinciweb/common/widgets/products/card_product.dart';
import 'package:davinciweb/features/shop/controllers/product/product_controller.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      appBar: HomeAppBar(),
      body: Obx(() {
        if (controller.isLoading.value && controller.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.products.isEmpty) {
          return const Center(child: Text('No hay productos disponibles'));
        } else {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(DaVinciSizes.spaceBtwItems),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width < 600
                        ? 2
                        : MediaQuery.of(context).size.width < 900
                            ? 3
                            : 4,
                    crossAxisSpacing: DaVinciSizes.spaceBtwItems,
                    mainAxisSpacing: DaVinciSizes.spaceBtwItems,
                    childAspectRatio: 3 / 2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final product = controller.products[index];
                      return ProductCard(product: product);
                    },
                    childCount: controller.products.length,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: controller.hasMoreProducts.value
                    ? Center(
                        child: ElevatedButton(
                          onPressed: () => controller.fetchMoreProducts(),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator()
                              : const Text('Cargar más'),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              SliverToBoxAdapter(
                child: Footer(),
              ),
            ],
          );
        }
      }),
    );
  }
}
