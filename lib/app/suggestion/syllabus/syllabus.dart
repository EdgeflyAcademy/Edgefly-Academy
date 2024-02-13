import 'package:flutter/material.dart';

class SyllabusPage extends StatelessWidget {
  const SyllabusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syllabus'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Lecture $index',
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
