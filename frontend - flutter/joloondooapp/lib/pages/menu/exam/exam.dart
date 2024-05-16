import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:joloondooapp/pages/menu/exam/exam_review.dart';

// ignore: must_be_immutable
class ExamPage extends StatefulWidget {
  List<dynamic> questions;

  ExamPage({super.key, required this.questions});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  int currentIndex = 0;
  Map<String, int> selectedAnswers = {};
  final _timerKey = GlobalKey<ExamTimerState>();

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchQuestions().then((questions) {
      setState(() {
        widget.questions = questions;
      });
    });
  }

  Future<List<dynamic>> fetchQuestions() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/get_exam'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['questions'].entries.toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шалгалт',
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
      body: Column(
        children: [
          ExamTimer(
            key: _timerKey,
            onTimeUp: _submitExam,
          ),
          Expanded(
            child: PageView.builder(
              itemCount: widget.questions.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                MapEntry questionEntry = widget.questions[index];
                String questionId = questionEntry.key;
                Map questionData = questionEntry.value;

                String imageUrl =
                    'http://127.0.0.1:8000/media/${Uri.encodeFull(questionData['image'])}';

                return Column(
                  children: [
                    Text(questionData['text'] ?? 'No text'),
                    if (questionData['image'] != null)
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ...questionData['answers'].map<Widget>((answer) {
                      return RadioListTile(
                        value: answer['answer_id'],
                        groupValue: selectedAnswers[questionId],
                        onChanged: (dynamic value) {
                          setState(() {
                            if (value != null) {
                              selectedAnswers[questionId] = value;
                            }
                          });
                        },
                        title: Text(answer['text']),
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
          Text('Асуулт: ${currentIndex + 1} Нийт: ${widget.questions.length}'),
          if (currentIndex == widget.questions.length - 1)
            ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(200, 50))),
              onPressed: _submitExam,
              child: const Text(
                'Дуусгах',
                style: TextStyle(color: Color(0xFF1a2a5e), fontSize: 20),
              ),
            ),
        ],
      ),
    );
  }

  void _submitExam() async {
    const url = 'http://127.0.0.1:8000/submit_exam';

    String? token = await storage.read(key: 'auth_token');
    print('Token: $token');

    final data = {
      'score': _calculateScore(),
      'time_taken': 20 * 60 - _timerKey.currentState!._secondsLeft,
      'answers':
          selectedAnswers.map((key, value) => MapEntry(key, value.toString())),
    };

    print('Data: $data');

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      print('Exam submitted successfully');
      Map<String, dynamic> responseData = json.decode(response.body);
      int examId = responseData['exam_score_id'];
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ExamReview(examId: examId)));
    } else {
      print('Error submitting exam: ${response.body}');
    }
  }

  int _calculateScore() {
    int score = 0;
    for (var question in widget.questions) {
      String questionId = question.key;
      Map questionData = question.value;
      List<dynamic> answers = questionData['answers'];
      int? correctAnswerId = answers
          .firstWhere((answer) => answer['a_iscorrect'] == true)['answer_id'];
      if (correctAnswerId != null &&
          selectedAnswers[questionId] == correctAnswerId) {
        score++;
      }
    }
    return score;
  }
}

class ExamTimer extends StatefulWidget {
  final VoidCallback onTimeUp;

  const ExamTimer({Key? key, required this.onTimeUp}) : super(key: key);

  @override
  ExamTimerState createState() => ExamTimerState();
}

class ExamTimerState extends State<ExamTimer> {
  late final Timer _timer;
  int _secondsLeft = 20 * 60;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
        widget.onTimeUp();
      } else {
        setState(() {
          _secondsLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _secondsLeft ~/ 60;
    final seconds = _secondsLeft % 60;
    return Text('Үлдсэн хугацаа: ${minutes}m ${seconds}s');
  }
}
