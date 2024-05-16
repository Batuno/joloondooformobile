import 'package:flutter/material.dart';

class SubjectsDetail extends StatefulWidget {
  final Map subject;
  const SubjectsDetail({super.key, required this.subject});

  @override
  State<SubjectsDetail> createState() => _SubjectsDetailState();
}

class _SubjectsDetailState extends State<SubjectsDetail> {
  @override
  Widget build(BuildContext context) {
    String baseUrl = 'http://127.0.0.1:8000/';
    String imageUrl =
        '${baseUrl}media/${Uri.encodeFull(widget.subject['s_images'])}';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject['s_name'] ?? 'No Name'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            widget.subject['s_images'] != null
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  )
                : const Center(child: Text('No image')),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.subject['s_text'] ?? 'No text available',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
