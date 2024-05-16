import 'package:flutter/material.dart';

class Signupbutton extends StatelessWidget {
  final VoidCallback onTap;
  const Signupbutton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: const Color(0xFF1a2a5e),
            borderRadius: BorderRadius.circular(15)),
        child: const Center(
            child: Text(
          'Sign up',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        )),
      ),
    );
  }
}
