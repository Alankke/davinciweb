import 'package:davinciweb/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: HomeAppBar(),
        body: Center(child: Text('Bienvenido a da vinci web')));
  }
}
