import 'package:flutter/material.dart';
import 'package:joloondooapp/pages/login/login_page.dart';
import 'package:joloondooapp/pages/signup/components/signup_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    Future<void> register() async {
      var url = 'http://127.0.0.1:8000/registeruser';
      var response = await http.post(
        Uri.parse(url),
        body: {
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'username': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'phone': phoneController.text,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Registered successfully');
        print(data);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      } else {
        print('Failed to register');
        print(response.body);
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: size.width * 0.8,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(color: Color(0xFF1a2a5e)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1a2a5e),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.016),
                  TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: TextStyle(color: Color(0xFF1a2a5e)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1a2a5e),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.016),
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Color(0xFF1a2a5e)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1a2a5e),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.016),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Color(0xFF1a2a5e)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1a2a5e),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.016),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color(0xFF1a2a5e)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1a2a5e),
                          width: 1,
                        ),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: size.height * 0.016),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: Color(0xFF1a2a5e)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1a2a5e),
                          width: 1,
                        ),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: size.height * 0.016),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      labelStyle: TextStyle(color: Color(0xFF1a2a5e)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1a2a5e),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Signupbutton(onTap: register),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
