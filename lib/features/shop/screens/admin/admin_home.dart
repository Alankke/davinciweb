import 'package:davinciweb/features/shop/screens/admin/CRUD/manage_products.dart';
import 'package:davinciweb/features/shop/screens/admin/CRUD/create_product.dart';
import 'package:davinciweb/features/shop/screens/admin/CRUD/manage_sales.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/common/widgets/appbar/admin_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminAppBar(),
      body: const Center(
          child: Text('Bienvenido al panel de administración',
              style: DaVinciTextStyles.headlineLargeDark)),
      drawer: Drawer(
        backgroundColor: DaVinciColors.midnight,
        child: ListView(
          children: [
            ListTile(
                leading: const Icon(Icons.add_outlined,
                    color: DaVinciColors.textWhite),
                title: const Text('Agregar producto',
                    style: DaVinciTextStyles.drawer),
                onTap: () => Get.to(const CreateProduct())),
            ListTile(
                leading: const Icon(Icons.inventory_2_outlined,
                    color: DaVinciColors.textWhite),
                title: const Text('Administrar productos',
                    style: DaVinciTextStyles.drawer),
                onTap: () =>
                    Get.to(const ManageProducts()) //Crear pantalla de lista de productos
                ),
            ListTile(
                leading: const Icon(Icons.sell_outlined,
                    color: DaVinciColors.textWhite),
                title: const Text('Administrar ventas',
                    style: DaVinciTextStyles.drawer),
                onTap: () =>
                    Get.to(const ManageSales()) //Crear pantalla de lista de ventas
                )
          ],
        ),
      ),
    );
  }
}
