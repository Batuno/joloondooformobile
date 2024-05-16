import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a2a5e),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/images/joloondoo.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'About Us',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Замын хөдөлгөөний дүрмийн шалгалтанд бэлдэгчдэд зориулсан цогц платформ.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            // const SizedBox(height: 20),
            // const Text(
            //   'Contact Us',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 10),
            // const Text(
            //   'Email: info@ourcompany.com',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //   ),
            // ),
            // const Text(
            //   'Phone: +1 123 456 7890',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
