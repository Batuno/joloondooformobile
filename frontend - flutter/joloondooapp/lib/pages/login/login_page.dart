import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:joloondooapp/pages/components/appstate.dart';
import 'package:joloondooapp/pages/home_page.dart';
import 'dart:convert';
import 'package:joloondooapp/pages/login/components/login_button.dart';
import 'package:joloondooapp/pages/signup/signup_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final storage = const FlutterSecureStorage();

  Future<void> login() async {
    var url = 'http://127.0.0.1:8000/loginuser';
    var response = await http.post(
      Uri.parse(url),
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var loggedInUserId = data['user_id'];
      var token = data['token'];
      await storage.write(key: 'auth_token', value: token);
      Provider.of<AppState>(context, listen: false).setUserId(loggedInUserId);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
      print('Logged in successfully');
      print(data);
    } else {
      print('Failed to log in');
      print(data);
    }
  }

  void goToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

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
        child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),
              Image.asset(
                'assets/images/introsha.png',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: size.height * 0.09,
              ),
              Container(
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
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Color(0xFF1a2a5e)),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Signinbutton(onTap: login),
                    TextButton(
                      onPressed: goToRegisterPage,
                      child: const Text('Not registered? Register here'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
