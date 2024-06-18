import 'package:davinciweb/features/shop/controllers/product/product_controller.dart';
import 'package:davinciweb/features/shop/models/product_model.dart';
import 'package:davinciweb/data/repositories/shop/product_repository.dart';
import 'package:davinciweb/utils/constants/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  //Lógicas
  final Rx<ProductModel> product = ProductModel.emptyProduct().obs;
  final productRepository = Get.put(ProductRepository());
  final productController = Get.put(ProductController());
  GlobalKey<FormState> createProductKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  //Form
  final name = TextEditingController();
  final price = TextEditingController();
  String category = '';
  String picture = '';

  @override
  void onInit() {
    super.onInit();
    //Cargar datos al formulario si el producto no es nuevo (si esta editando el producto en lugar de estar creando uno nuevo)
    if (Get.arguments != null) {
      final productToEdit = Get.arguments as ProductModel;
      product.value = productToEdit;
      name.text = productToEdit.name;
      price.text = productToEdit.price.toString();
      category = productToEdit.category;
      picture = productToEdit.picture;
    }
  }

  void createProduct() async {
    try {
      if (createProductKey.currentState != null &&
          createProductKey.currentState!.validate()) {
        //Llena los datos de ProductModel con los datos ingresados por el usuario
        Map<String, dynamic> productData = {
          'Name': name.text.trim(),
          'Price': double.parse(price.text.trim()),
          'Category': category,
          'Picture': product.value.picture,
        };

        if (product.value.id.isEmpty) {
          //Crear nuevo producto
          await productRepository.saveProductRecord(productData);
          DaVinciSnackBars.success('Producto creado con éxito');
        } else {
          //Actualizar producto existente
          await productRepository.updateSingleField(
              productData, product.value.id);
          DaVinciSnackBars.success('Producto actualizado con éxito');
        }
      }
    } on Exception catch (e) {
      DaVinciSnackBars.error(
          'Se ha producido un error, intente nuevamente más tarde');
      throw 'Se produjo un error al guardar su producto $e';
    }
  }

  //Método para seleccionar la imagen con el paquete y guardarla a firebase storage
  void selectPicture() async {
    //Pide al usuario que seleccione una imagen
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      //Si seleccionó una imagen se esta subiendo a storage
      isLoading.value = true;
      try {
        //Llama a repository para registrar la imagen en storage (en la carpeta/directorio Products/)
        final imageUrl =
            await productRepository.uploadImage("Products/", image);
        //Actualiza el estado del formulario para mostrar la imagen seleccionada
        product.update((val) {
          val!.picture = imageUrl;
        });
      } finally {
        isLoading.value = false;
      }
    }
  }
}
