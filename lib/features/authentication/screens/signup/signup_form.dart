import 'package:davinciweb/features/authentication/controllers/signup/signup_controller.dart';
import 'package:davinciweb/features/authentication/screens/login/login.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:davinciweb/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  final bool isAdminCreation;
  const SignUpForm({
    super.key,
    this.isAdminCreation = false,
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
            const SizedBox(height: DaVinciSizes.spaceBtwItems / 2),
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
            const SizedBox(height: DaVinciSizes.spaceBtwItems / 2),
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
            const SizedBox(height: DaVinciSizes.spaceBtwItems / 2),
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
            const SizedBox(height: DaVinciSizes.spaceBtwItems / 2),
            //button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(isAdminCreation ? 'Crear cuenta de administrador' : 'Registrarte'),
                  ),
                  onPressed: () => isAdminCreation ? controller.createAdminAccount() : controller.signup()),
            ),
            if(!isAdminCreation)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('¿Ya tienes una cuenta?'),
                TextButton(child: const Text('Iniciar sesión'), onPressed: () => Get.off(() => const LogIn()))
              ],
            )
          ],
        ),
      ),
    );
  }
}
