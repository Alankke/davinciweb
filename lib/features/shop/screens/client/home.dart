import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:davinciweb/common/widgets/appbar/appbar.dart';
import 'package:davinciweb/common/widgets/custom_shapes/footer.dart';
import 'package:davinciweb/common/widgets/products/card_product.dart';
import 'package:davinciweb/features/shop/controllers/product_controller.dart';
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
      body: FutureBuilder<List<ProductModel>>(
        future: controller.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('Error al cargar productos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Cargando productos, vuelva más tarde'));
          } else {
            final products = snapshot.data!;

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
                        final product = products[index];
                        return ProductCard(product: product);
                      },
                      childCount: products.length,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Footer(), // Footer at the end
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
