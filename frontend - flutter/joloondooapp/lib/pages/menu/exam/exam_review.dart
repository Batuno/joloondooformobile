import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:joloondooapp/pages/home_page.dart';

class ExamReview extends StatefulWidget {
  final int examId;
  const ExamReview({super.key, required this.examId});

  @override
  State<ExamReview> createState() => _ExamReviewState();
}

class _ExamReviewState extends State<ExamReview> {
  final storage = const FlutterSecureStorage();
  late int userId;

  Future<List<dynamic>> fetchExamReview() async {
    String? token;
    try {
      token = await storage.read(key: 'auth_token');
      userId = int.parse(await storage.read(key: 'userId') ?? '0');
      print('Token: $token');
    } catch (e) {
      print('Failed to read auth_token: $e');
      throw Exception('Failed to read auth_token: $e');
    }
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/exam_review/${widget.examId}/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['questions'].entries.toList();
    } else {
      throw Exception('Failed to load exam review');
    }
  }

  List<dynamic> questions = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    fetchExamReview().then((data) {
      setState(() {
        questions = data;
        score = questions.fold<int>(0, (sum, question) {
          bool isCorrect = question.value['answers'].any((answer) =>
              answer['user_answer'] == true && answer['correct'] == true);
          return isCorrect ? sum + 1 : sum;
        });
        print('Total score: $score');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Хариу',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Text(score >= 18
              ? 'Та тэнцлээ баяр хүргэе!'
              : 'Та тэнцсэнгүй, дараагийн удаа илүү хичээгээрэй!'),
          Text('Оноо: $score'),
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                MapEntry questionEntry = questions[index];
                // String questionId = questionEntry.key;
                Map questionData = questionEntry.value;
                String imageUrl =
                    'http://127.0.0.1:8000/media/${Uri.encodeFull(questionData['image'])}';
                return Column(
                  children: [
                    Text(questionData['explanation'] ?? 'No explanation'),
                    if (questionData['image'] != null)
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ...questionData['answers'].map<Widget>((answer) {
                      Icon leadingIcon;
                      Color textColor;
                      if (answer['correct']) {
                        leadingIcon =
                            const Icon(Icons.check_circle, color: Colors.green);
                        textColor = Colors.green;
                      } else if (answer['user_answer']) {
                        leadingIcon =
                            const Icon(Icons.cancel, color: Colors.red);
                        textColor = Colors.red;
                      } else {
                        leadingIcon = const Icon(Icons.radio_button_unchecked,
                            color: Colors.grey);
                        textColor = Colors.black;
                      }
                      return ListTile(
                        leading: leadingIcon,
                        title: Text(answer['text'],
                            style: TextStyle(color: textColor)),
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
