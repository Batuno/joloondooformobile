import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:joloondooapp/pages/menu/subject/subjects_detail.dart';

class Subjects extends StatefulWidget {
  const Subjects({super.key});

  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  List subjects = [];

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  fetchSubjects() async {
    var url = 'http://127.0.0.1:8000/getsubject'; // replace with your API url
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    setState(() {
      subjects = data["subjects"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дүрэм',
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
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              subjects[index]['s_name'],
              style: const TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SubjectsDetail(subject: subjects[index]),
                ),
              );
              print('You tapped on ${subjects[index]['s_name']}');
            },
          );
        },
      ),
    );
  }
}
