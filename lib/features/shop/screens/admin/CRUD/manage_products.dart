import 'package:davinciweb/features/shop/controllers/product/product_controller.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:davinciweb/features/shop/screens/admin/CRUD/create_product.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:davinciweb/utils/formatters/formatter.dart';
import 'package:davinciweb/common/widgets/appbar/admin_appbar.dart';
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
          if (productController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (productController.products.isEmpty) {
            return const Center(child: Text('No hay productos disponibles'));
          }
          return ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              ProductModel product = productController.products[index];
              return ListTile(
                leading: Image.network(product.picture, width: 50, height: 50),
                title: Text(product.name),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.category),
                      Text(DaVinciFormatter.formatCurrency(product.price))
                    ]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: DaVinciColors.primary),
                      onPressed: () async {
                        var result = await Get.to(() => const CreateProduct(), arguments: product);
                        if (result != null && result) {
                          productController.fetchInitialProducts(); // Actualiza los productos después de editar
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: DaVinciColors.error),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirmar acción', style: DaVinciTextStyles.dialogTitle),
                            content: const Text('¿Estas seguro de que quieres eliminar el producto?'),
                            actions: [
                              TextButton(onPressed: ()=> Navigator.of(context).pop(), child: const Text('Cancelar')),
                              TextButton(
                                onPressed:() async {
                                  await productController.deleteProduct(product.id);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Eliminar'))
                            ],
                          )
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
