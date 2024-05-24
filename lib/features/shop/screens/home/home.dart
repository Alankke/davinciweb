import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:davinciweb/common/widgets/appbar/appbar.dart';
import 'package:davinciweb/common/widgets/custom_shapes/footer.dart';
import 'package:davinciweb/common/widgets/products/card_product.dart';
import 'package:davinciweb/features/shop/controllers/products/product_controller.dart';
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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ProductModel>>(
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

                  return CustomGridView(products: products);
                }
              },
            ),
          ),
          Footer()
        ],
      ),
    );
  }
}

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 600;
    final bool isMediumScreen = width > 600 && width < 900;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isSmallScreen? 2 : isMediumScreen ? 3 : 4,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: DaVinciSizes.spaceBtwItems,
        mainAxisSpacing: DaVinciSizes.spaceBtwItems,
      ),
      itemCount: products.length,
      itemBuilder: (BuildContext context, index) {
        final product = products[index];
        return ProductCard(product: product);
      },
    );
  }
}
