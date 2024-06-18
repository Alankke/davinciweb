import 'package:davinciweb/features/shop/controllers/product/create_product_controller.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:davinciweb/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CreateProductForm extends StatelessWidget {
  const CreateProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        constraints: BoxConstraints(maxWidth: width / 2),
        child: Form(
          key: controller.createProductKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: DaVinciSizes.spaceBtwItems),
              //Imagen
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return SizedBox(
                    width: 200,
                    height: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => controller.selectPicture(),
                      child: Obx(() {
                        final networkImage = controller.product.value.picture;
                        return networkImage.isEmpty
                            ? const Icon(Icons.landscape,
                                color: DaVinciColors.dark)
                            : controller.isLoading.value == true
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Image.network(networkImage);
                      }),
                    ),
                  );
                },
              ),
              const SizedBox(height: DaVinciSizes.spaceBtwItems),
              //Nombre producto
              TextFormField(
                  controller: controller.name,
                  validator: (value) => DaVinciValidator.validateEmptyText(
                      'Nombre del producto', value),
                  decoration: const InputDecoration(
                      labelText: 'Nombre del producto',
                      prefixIcon: Icon(Icons.text_fields_outlined),
                      border: OutlineInputBorder())),
              const SizedBox(height: DaVinciSizes.spaceBtwItems),
              //Precio producto
              TextFormField(
                  controller: controller.price,
                  validator: (value) =>
                      DaVinciValidator.validateEmptyText('Precio', value),
                  decoration: const InputDecoration(
                      labelText: 'Precio del producto',
                      prefixIcon: Icon(Icons.attach_money_outlined),
                      border: OutlineInputBorder())),
              const SizedBox(height: DaVinciSizes.spaceBtwItems),
              //Categoría producto
              DropdownButtonFormField<String>(
                value: controller.category.isNotEmpty ? controller.category : null,
                onChanged: (String? newValue) {
                  controller.category = newValue!;
                },
                validator: (value) => DaVinciValidator.validateEmptyText(
                    'Categoría del producto', value.toString()),
                decoration: const InputDecoration(
                  labelText: 'Categoría del producto',
                  prefixIcon: Icon(Icons.category_outlined),
                  border: OutlineInputBorder(),
                ),
                items: <String>[
                  'Lentes de contacto',
                  'Anteojos de sol',
                  'Anteojos de receta',
                  'Accesorios',
                ].map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              const SizedBox(height: DaVinciSizes.spaceBtwItems),
              //Guardar producto
              ElevatedButton(
                  onPressed: () => controller.createProduct(),
                  child: const Text('Guardar producto'))
            ],
          ),
        ),
      ),
    );
  }
}

