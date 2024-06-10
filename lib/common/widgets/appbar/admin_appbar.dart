import 'package:davinciweb/common/widgets/appbar/admin_header.dart';
import 'package:davinciweb/features/authentication/controllers/login/login_controller.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LogInController());
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(200);

}
