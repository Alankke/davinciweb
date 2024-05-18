import 'package:davinciweb/common/widgets/custom_shapes/admin_header.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: DaVinciColors.midnight,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: DaVinciColors.light),
        flexibleSpace: const AdminHeader());
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(200);
}