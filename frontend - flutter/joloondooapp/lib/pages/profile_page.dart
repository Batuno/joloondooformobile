import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:joloondooapp/pages/login/login_page.dart';

class ProfilePage extends StatefulWidget {
  final int userId;
  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<Map<String, dynamic>> getUserData() async {
    http.Response response = await http.post(
      Uri.parse('http://127.0.0.1:8000/getuser'),
      body: jsonEncode({'user_id': widget.userId}),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data)['respRow'][0];
    } else {
      print('Failed to load user data: ${response.statusCode}');
      return {};
    }
  }

  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final userData = snapshot.data ?? {};
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(10),
                    children: [
                      ListTile(
                        leading: Icon(Icons.person,
                            color: Theme.of(context).primaryColor),
                        title: Text(
                            'Хэрэглэгчийн нэр : ${userData['username'] ?? 'N/A'}'),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.email,
                            color: Theme.of(context).primaryColor),
                        title: Text(
                            'Цахим шуудан : ${userData['email'] ?? 'N/A'}'),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.account_circle,
                            color: Theme.of(context).primaryColor),
                        title: Text('Нэр : ${userData['first_name'] ?? 'N/A'}'),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.account_circle,
                            color: Theme.of(context).primaryColor),
                        title: Text('Овог : ${userData['last_name'] ?? 'N/A'}'),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.phone,
                            color: Theme.of(context).primaryColor),
                        title: Text('Утас : ${userData['phone'] ?? 'N/A'}'),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all(const Size(200, 50))),
                  onPressed: logout,
                  child: const Text(
                    'Гарах',
                    style: TextStyle(color: Color(0xFF1a2a5e), fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
      },
    );
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:joloondooapp/pages/login/login_page.dart';

// class ProfilePage extends StatefulWidget {
//   final int userId;
//   const ProfilePage({super.key, required this.userId});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   Map<String, dynamic> userData = {};

//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//   }

//   Future<Map<String, dynamic>> getUserData() async {
//     http.Response response = await http.post(
//       Uri.parse('http://127.0.0.1:8000/getuser'),
//       body: jsonEncode({'user_id': widget.userId}),
//       headers: {"Content-Type": "application/json"},
//     );
//     if (response.statusCode == 200) {
//       String data = response.body;
//       var decodedData = jsonDecode(data);
//       return decodedData['respRow'][0];
//     } else {
//       print(response.statusCode);
//       return {};
//     }
//   }

//   void logout() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const LoginPage(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, dynamic>>(
//       future: getUserData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             Map<String, dynamic> userData = snapshot.data ?? {};
//             return Scaffold(
//               body: Column(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: ListTile(
//                             title:
//                                 Text('Username: ${userData['username'] ?? ''}'),
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: ListTile(
//                             title: Text('Email: ${userData['email'] ?? ''}'),
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: ListTile(
//                             title: Text(
//                                 'First Name: ${userData['first_name'] ?? ''}'),
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: ListTile(
//                             title: Text(
//                                 'Last Name: ${userData['last_name'] ?? ''}'),
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: ListTile(
//                             title: Text('Phone: ${userData['phone'] ?? ''}'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   ElevatedButton(
//                     style: ButtonStyle(
//                         fixedSize:
//                             MaterialStateProperty.all(const Size(200, 50))),
//                     onPressed: logout,
//                     child: const Text(
//                       'Гарах',
//                       style: TextStyle(color: Color(0xFF1a2a5e), fontSize: 20),
//                     ),
//                   ),
//                   const SizedBox(height: 20)
//                 ],
//               ),
//             );
//           }
//         }
//       },
//     );
//   }
// }
