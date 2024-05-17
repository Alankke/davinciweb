import 'package:davinciweb/common/styles/text_style.dart';
import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Row(children: [
      SearchBar(),
      Expanded(
        child: Text('DA VINCI WEB',
            style: DaVinciTextStyles.appBarTitleText,
            textAlign: TextAlign.center),
      )
    ]));
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: DaVinciColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: DaVinciColors.grey)),
            child: const Row(children: [
              Icon(Icons.search_outlined, color: DaVinciColors.grey),
              SizedBox(width: DaVinciSizes.spaceBtwInputFields),
              Text('Buscar productos',
                  style: DaVinciTextStyles.appBarTextStyleSm)
            ])));
  }
}
