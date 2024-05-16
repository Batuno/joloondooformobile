import 'package:flutter/material.dart';

class PractiseQuestions extends StatefulWidget {
  final List<dynamic> questions;

  const PractiseQuestions({super.key, required this.questions});

  @override
  State<PractiseQuestions> createState() => _PractiseQuestionsState();
}

class _PractiseQuestionsState extends State<PractiseQuestions> {
  int currentIndex = 0;
  Map<int, String> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    String baseUrl = 'http://127.0.0.1:8000/';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дасгалууд',
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
          Expanded(
            child: PageView.builder(
              itemCount: widget.questions.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                String imageUrl =
                    '${baseUrl}media/${Uri.encodeFull(widget.questions[index]['q_images'])}';
                return Column(
                  children: [
                    Text(widget.questions[index]['q_text'] ?? 'No text'),
                    if (widget.questions[index]['q_images'] != null)
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ...widget.questions[index]['answers'].map<Widget>((answer) {
                      bool isSelected =
                          selectedAnswers[index] == answer['a_text'];
                      Icon icon = isSelected
                          ? (answer['a_iscorrect']
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : const Icon(Icons.cancel, color: Colors.red))
                          : const Icon(null);
                      return RadioListTile(
                        value: answer['a_text'],
                        groupValue: selectedAnswers[index],
                        onChanged: (dynamic value) {
                          setState(() {
                            selectedAnswers[index] = value;
                          });
                        },
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(answer['a_text']),
                            const SizedBox(width: 10),
                            if (isSelected) icon,
                          ],
                        ),
                        activeColor:
                            answer['a_iscorrect'] ? Colors.green : Colors.red,
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
          Text('Асуулт: ${currentIndex + 1} Нийт: ${widget.questions.length}'),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class PractiseQuestions extends StatefulWidget {
//   final List<dynamic> questions;

//   const PractiseQuestions({super.key, required this.questions});

//   @override
//   State<PractiseQuestions> createState() => _PractiseQuestionsState();
// }

// class _PractiseQuestionsState extends State<PractiseQuestions> {
//   int currentIndex = 0;
//   Map<int, String> selectedAnswers = {};

//   @override
//   Widget build(BuildContext context) {
//     String baseUrl = 'http://127.0.0.1:8000/';
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Дасгалууд',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView.builder(
//               itemCount: widget.questions.length,
//               onPageChanged: (index) {
//                 setState(() {
//                   currentIndex = index;
//                 });
//               },
//               itemBuilder: (context, index) {
//                 String imageUrl = '${baseUrl}media/${Uri.encodeFull(widget.questions[index]['q_images'])}';
//                 return Column(
//                   children: [
//                     Text(widget.questions[index]['q_text'] ?? 'No text'),
//                     if (widget.questions[index]['q_images'] != null)
//                       Image.network(
//                         imageUrl,
//                         fit: BoxFit.cover,
//                       ),
//                     ...widget.questions[index]['answers'].map<Widget>((answer) {
//                       bool isSelected = selectedAnswers[index] == answer['a_text'];
//                       Icon icon = isSelected ? (answer['a_iscorrect'] ? Icon(Icons.check_circle, color: Colors.green) : Icon(Icons.cancel, color: Colors.red)) : Icon(null);
//                       return RadioListTile<String>(
//                         value: answer['a_text'],
//                         groupValue: selectedAnswers[index],
//                         onChanged: (String? value) {
//                           setState(() {
//                             selectedAnswers[index] = value;
//                           });
//                         },
//                         title: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Expanded(child: Text(answer['a_text'])),
//                             if (isSelected) icon, 
//                           ],
//                         ),
//                         activeColor:
//                             answer['a_iscorrect'] ? Colors.green : Colors.red,
//                       );
//                     }).toList(),
//                   ],
//                 );
//               },
//             ),
//           ),
//           Text(' ${currentIndex + 1} / ${widget.questions.length}'),
//         ],
//       ),
//     );
//   }
// }



