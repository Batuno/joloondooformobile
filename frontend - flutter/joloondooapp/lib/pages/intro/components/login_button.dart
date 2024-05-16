import 'package:flutter/material.dart';

class LoginIntro extends StatelessWidget {
  const LoginIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 65),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: const Center(
            child: Text(
          'Sign in',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        )),
      ),
    );
  }
}
