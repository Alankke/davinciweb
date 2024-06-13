import 'package:davinciweb/common/widgets/appbar/admin_header.dart';
import 'package:davinciweb/features/authentication/controllers/login/login_controller.dart';
import 'package:davinciweb/features/shop/screens/admin/CRUD/create_product_form.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProduct extends StatelessWidget {
  const CreateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LogInController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=> Get.back(result: true), icon: const Icon(Icons.arrow_back)),
        backgroundColor: DaVinciColors.midnight,
        automaticallyImplyLeading: true,
        foregroundColor: DaVinciColors.light,
        iconTheme: const IconThemeData(color: DaVinciColors.light),
        flexibleSpace: const AdminHeader(),
        actions: [
          TextButton(
            child: const Text('Cerrar Sesión',
                style: DaVinciTextStyles.appBarTextStyleMd),
            onPressed: () => loginController.logout(),
          )
        ],
      ), 
      body: const CreateProductForm()
    
    );
  }
}
