import 'package:davinciweb/common/widgets/appbar/admin_appbar.dart';
import 'package:davinciweb/features/shop/screens/admin/CRUD/create_product_form.dart';
import 'package:flutter/material.dart';

class CreateProduct extends StatelessWidget {
  const CreateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: AdminAppBar(), body: CreateProductForm());
  }
}
