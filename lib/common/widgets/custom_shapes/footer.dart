import 'package:davinciweb/utils/constants/colors.dart';
import 'package:davinciweb/utils/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Footer extends StatelessWidget {
  Footer({super.key});

  final List<Widget> paymentMethods = [
    Tooltip(
        message: 'Pago en efectivo',
        child: Image.asset('assets/icons/dinero.png', width: 60, height: 31)),
    Tooltip(
        message: 'MercadoPago',
        child: Image.asset('assets/icons/mp_logo.png', width: 60, height: 31)),
    Tooltip(
        message: 'Transferencia Bancaria',
        child: Image.asset('assets/icons/transfer.png', width: 60, height: 31))
  ];

  final List<Widget> socialMedia = [
    IconButton(
      icon: Image.asset('assets/logos/facebook.png', width: 24, height: 24),
      onPressed: () => launchUrlString(
          'https://www.facebook.com/profile.php?id=100063462973717'),
    ),
    IconButton(
      icon: Image.asset('assets/logos/instagram.png', width: 24, height: 24),
      onPressed: () =>
          launchUrlString('https://www.instagram.com/opticadavinci/'),
    ),
    IconButton(
        icon: Image.asset('assets/logos/whatsapp.png', width: 24, height: 24),
        onPressed: () => launchUrlString('https://wa.me/+543794070513')),
  ];

  @override
  Widget build(BuildContext context) {
    double contextWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: AlignmentDirectional.bottomCenter,
      width: contextWidth,
      height: 150,
      color: DaVinciColors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 2.0),
                child: Text('MEDIOS DE PAGO',
                    style: DaVinciTextStyles.FooterTitle),
              ),
              Row(
                children: paymentMethods,
              )
            ],
          ),
          //Contacto
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 2.0),
                child:
                    Text('CONTACTANOS', style: DaVinciTextStyles.FooterTitle),
              ),
              TextButton(
                  onPressed: () =>
                      launchUrlString('https://wa.me/+543794070513'),
                  child: const Text('+54 379-4070513',
                      style: TextStyle(color: DaVinciColors.textPrimary))),
              TextButton(
                  onPressed: () => launchUrlString(
                      'https://maps.app.goo.gl/H6XtFHQ9CDD7Y74H8'),
                  child: const Text('Junín 798',
                      style: TextStyle(color: DaVinciColors.textPrimary))),
            ],
          ),
          //Redes sociales
          Column(
            children: [
            const Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 2.0),
              child:
                  Text('REDES SOCIALES', style: DaVinciTextStyles.FooterTitle),
            ),
            Row(
              children: socialMedia,
            )
          ])
        ],
      ),
    );
  }
}
