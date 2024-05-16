import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:joloondooapp/pages/menu/practise/practise_questions.dart';

class Practise extends StatefulWidget {
  const Practise({super.key});

  @override
  State<Practise> createState() => _PractiseState();
}

class _PractiseState extends State<Practise> {
  Map<String, List<dynamic>> subjects = {};
  List<String> subjectNames = [];

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  fetchSubjects() async {
    var url = 'http://127.0.0.1:8000/getquestion';
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    setState(() {
      subjects = Map<String, List>.from(data["respRow"]);
      subjectNames = subjects.keys.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дасгал ажил',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: subjectNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              subjectNames[index],
              style: const TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PractiseQuestions(
                      questions: subjects[subjectNames[index]] ?? []),
                ),
              );
            },
          );
        },
      ),
    );
  }
}




// class Practise extends StatefulWidget {
//   const Practise({super.key});

//   @override
//   State<Practise> createState() => _PractiseState();
// }

// class _PractiseState extends State<Practise> {
//   List subjects = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchQuestions();
//   }

//   fetchQuestions() async {
//     var url = 'http://127.0.0.1:8000/getquestion';
//     var response = await http.get(Uri.parse(url));
//     var data = jsonDecode(response.body);
//     setState(() {
//       subjects = data["respRow"];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1a2a5e),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: subjects.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(
//               subjects[index] ?? 'No name',
//               style: const TextStyle(color: Colors.white),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       PractiseQuestions(questions: subjects[index]),
//                 ),
//               );
//               print('You tapped on ${subjects[index]}');
//             },
//           );
//         },
//       ),
//     );
//   }
// }
