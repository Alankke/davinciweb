// ignore_for_file: avoid_print
import 'package:davinciweb/data/repositories/shop/product_repository.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:davinciweb/utils/enums/product_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  //Lógicas
  final Rx<ProductModel> product = ProductModel.emptyProduct().obs;
  final productRepository = Get.put(ProductRepository());
  GlobalKey<FormState> createProductKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  //Form
  final name = TextEditingController();
  final price = TextEditingController();
  ProductCategory category = ProductCategory.noCategory;
  String picture = '';

  //Selecciona la imagen con el paquete y actualiza la imagen actual con método.
  selectPicture() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      isLoading.value = true;
      try {
        final imageUrl = await productRepository.uploadImage("Products/", image);
        product.update((val) {
          val!.picture = imageUrl;
        });
      } finally {
        isLoading.value = false;
      }
    }
  }

  createProduct() async {
    try {
      if (createProductKey.currentState != null &&
          createProductKey.currentState!.validate()) {
        Map<String, dynamic> newProduct = {
          'Name': name.text.trim(),
          'Price': double.parse(price.text.trim()),
          'Category': category.toString().split('.').last,
          'Picture': product.value.picture,
        };

        await productRepository.saveProductRecord(newProduct);
        print('Producto creado con éxito');
      } else {
        print('El valor de productKey es nulo');
      }
    } on Exception catch (e) {
      throw 'Se produjo un error al crear su producto $e';
    }
  }
}
