import 'package:davinciweb/common/widgets/image_login_signup.dart';
import 'package:davinciweb/features/authentication/screens/signup/signup_form.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        body: Center(
            child: isSmallScreen
                //Mobile
                ? const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [SignUpForm(), Logo()],
                  )
                //Desktop
                : Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const Row(
                      children: [
                        Expanded(child: Center(child: SignUpForm())),
                        Expanded(child: Logo())
                      ],
                    ),
                  )));
  }
}
