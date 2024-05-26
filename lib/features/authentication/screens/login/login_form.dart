import 'package:davinciweb/features/authentication/controllers/login/login_controller.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:davinciweb/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LogInForm extends StatelessWidget {
  const LogInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogInController());

    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //email
            TextFormField(
              controller: controller.email,
              validator: (value) => DaVinciValidator.validateEmail(value),
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: DaVinciSizes.spaceBtwItems / 2),
            //password
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                validator: (value) =>
                    DaVinciValidator.validateEmptyText('Contraseña', value),
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
            const SizedBox(height: DaVinciSizes.spaceBtwItems / 2),
            //button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                        fontSize: DaVinciSizes.fontSizeMd,
                        fontWeight: FontWeight.bold,
                        color: DaVinciColors.textPrimary),
                  ),
                ),
                onPressed: () => controller.emailAndPasswordSignIn(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
