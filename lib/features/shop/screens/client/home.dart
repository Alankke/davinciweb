import 'package:davinciweb/common/widgets/appbar/appbar.dart';
import 'package:davinciweb/common/widgets/custom_shapes/footer.dart';
import 'package:davinciweb/common/widgets/products/product_card.dart';
import 'package:davinciweb/features/authentication/controllers/login/login_controller.dart';
import 'package:davinciweb/features/shop/controllers/cart/cart_controller.dart';
import 'package:davinciweb/features/shop/controllers/product/product_controller.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final loginController = Get.put(LogInController());
    final cartController = Get.put(CartController());

    return Scaffold(
      body: Obx(() {
        if (productController.isLoading.value && productController.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (productController.products.isEmpty) {
          return const Center(child: Text('No hay productos disponibles'));
        } else {
          return CustomScrollView(
            slivers: [
              HomeAppBar(productController: productController, loginController: loginController, cartController: cartController),
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
                      final product = productController.products[index];
                      return ProductCard(product: product);
                    },
                    childCount: productController.products.length,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: productController.hasMoreProducts.value
                    ? Center(
                        child: ElevatedButton(
                          onPressed: () => productController.fetchMoreProducts(),
                          child: productController.isLoading.value
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
