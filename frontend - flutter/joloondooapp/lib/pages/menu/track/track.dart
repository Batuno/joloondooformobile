import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:joloondooapp/pages/menu/exam/exam_review.dart';

class TrackPage extends StatefulWidget {
  final int userId;

  const TrackPage({super.key, required this.userId});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  final storage = const FlutterSecureStorage();
  List<dynamic> examHistory = [];

  @override
  void initState() {
    super.initState();
    fetchExamHistory().then((history) {
      setState(() {
        examHistory = history;
      });
    });
  }

  Future<List<dynamic>> fetchExamHistory() async {
    var url = 'http://127.0.0.1:8000/trackuser/${widget.userId}';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['exam_history'];
    } else {
      throw Exception('Failed to load exam history');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шалгалтын түүх'),
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
        itemCount: examHistory.length,
        itemBuilder: (context, index) {
          int timeTakenSeconds = examHistory[index]['time_taken'];
          int minutes = timeTakenSeconds ~/ 60;
          int seconds = timeTakenSeconds % 60;

          DateTime dateTaken = DateTime.parse(examHistory[index]['date_taken']);
          String formattedDate = DateFormat('yyyy/MM/dd').format(dateTaken);

          return Card(
            child: ListTile(
              title: Text('Шалгалт ${examHistory[index]['exam_id']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Оноо: ${examHistory[index]['score']}'),
                  Text('Он сар: $formattedDate'),
                  Text('Хугацаа: $minutes минут $seconds секунд'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ExamReview(examId: examHistory[index]['exam_id']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';

// class TrackPage extends StatefulWidget {
//   final int userId;

//   const TrackPage({super.key, required this.userId});

//   @override
//   State<TrackPage> createState() => _TrackPageState();
// }

// class _TrackPageState extends State<TrackPage> {
//   final storage = const FlutterSecureStorage();
//   List<dynamic> examHistory = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchExamHistory().then((history) {
//       setState(() {
//         examHistory = history;
//       });
//     });
//   }

//   Future<List<dynamic>> fetchExamHistory() async {
//     var url = 'http://127.0.0.1:8000/trackuser/${widget.userId}';
//     var response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = json.decode(response.body);
//       return data['exam_history'];
//     } else {
//       throw Exception('Failed to load exam history');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Шалгалтын түүх'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: examHistory.length,
//         itemBuilder: (context, index) {
//           int timeTakenSeconds = examHistory[index]['time_taken'];
//           int minutes = timeTakenSeconds ~/ 60;
//           int seconds = timeTakenSeconds % 60;

//           DateTime dateTaken = DateTime.parse(examHistory[index]['date_taken']);
//           String formattedDate = DateFormat('yyyy/MM/dd').format(dateTaken);

//           return Card(
//             child: ListTile(
//               title: Text('Шалгалт ${index + 1}'),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Оноо: ${examHistory[index]['score']}'),
//                   Text('Он сар: $formattedDate'),
//                   Text('Хугацаа: $minutes минут $seconds секунд'),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
