import 'package:davinciweb/features/authentication/screens/login/login.dart';
import 'package:davinciweb/features/authentication/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            TextButton(
              onPressed: () => {
                Navigator.push<void>(
                  context,
                   MaterialPageRoute<void>(
                    builder: (BuildContext context) => const LogIn()))},
              child: Text('LogIn')
              ),
            TextButton(
              onPressed: () => {
                Navigator.push<void>(
                  context,
                   MaterialPageRoute<void>(
                    builder: (BuildContext context) => const SignUp()))},
              child: Text('SignUp')
            )
          ],
        )
      )
    );
  }
}