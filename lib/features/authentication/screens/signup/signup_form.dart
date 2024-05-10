import 'package:davinciweb/common/widgets/custom_shapes/space_input_fields.dart';
import 'package:davinciweb/features/authentication/controllers/signup/signup_controller.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:davinciweb/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: controller.signupFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Email
            TextFormField(
              controller: controller.email,
              validator: (value) => DaVinciValidator.validateEmail(value),
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            spaceInputFields(),
            //Nombre
            TextFormField(
              controller: controller.name,
              validator: (value) =>
                  DaVinciValidator.validateEmptyText('Nombre', value),
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            spaceInputFields(),
            //Username
            TextFormField(
              controller: controller.username,
              validator: (value) => DaVinciValidator.validateUsername(value),
              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
                prefixIcon: Icon(Icons.text_fields_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            spaceInputFields(),
            //Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                validator: (value) => DaVinciValidator.validatePassword(value),
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined)),
                ),
              ),
            ),
            spaceInputFields(),
            //button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DaVinciColors.buttonSecondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Registrarte',
                      style: TextStyle(
                          fontSize: DaVinciSizes.fontSizeMd,
                          fontWeight: FontWeight.bold,
                          color: DaVinciColors.textPrimary),
                    ),
                  ),
                  onPressed: () => controller.signup()),
            ),
          ],
        ),
      ),
    );
  }
}