import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:flutter/material.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Row(children: [
      Expanded(
        child: Text('DA VINCI WEB ADMIN',
            style: DaVinciTextStyles.appBarTitleText,
            textAlign: TextAlign.center),
      )
    ]));
  }
}
