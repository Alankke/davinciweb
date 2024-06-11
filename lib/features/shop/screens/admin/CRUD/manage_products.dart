import 'package:davinciweb/common/widgets/appbar/admin_appbar.dart';
import 'package:davinciweb/features/shop/controllers/product/product_controller.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageProducts extends StatelessWidget {
  const ManageProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());

    return Scaffold(
      appBar: const AdminAppBar(),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              ProductModel product = productController.products[index];
              return ListTile(
              leading: Image.network(product.picture, width: 50, height: 50),
              title: Text(product.name),
              subtitle: Text(DaVinciFormatter.formatCurrency(product.price)),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: DaVinciColors.error),
                onPressed: () { //Eliminar producto (documento) de la base de datos.
                },
              ),
            );
          },
        );
      }),
    );
  }
}