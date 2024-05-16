import 'package:flutter/material.dart';
import 'package:joloondooapp/pages/intro/components/login_button.dart';
import 'package:joloondooapp/pages/intro/components/signup_button.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                //ehleed 1 zurag shaay
                Image.asset(
                  'assets/images/introsha.png',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: size.height * 0.03),
                const Text(
                  'Joloondoo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  'Joloogoo joloondootoi tugs3',
                  style: TextStyle(color: Colors.grey[200]),
                ),
                SizedBox(height: size.height * 0.05),
                const LoginIntro(),
                SizedBox(height: size.height * 0.03),
                const SignIntro(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
