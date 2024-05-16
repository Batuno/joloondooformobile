import 'package:flutter/material.dart';

class SignIntro extends StatelessWidget {
  const SignIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 65),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(15)),
        child: const Center(
            child: Text(
          'Sign up',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
