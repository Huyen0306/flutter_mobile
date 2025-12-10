import 'package:flutter/material.dart';

class HomeClassroomScreen extends StatelessWidget {
  const HomeClassroomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 1: Home Classroom'),
      ),
      body: const Center(
        child: Text('Nội dung Bài tập 1'),
      ),
    );
  }
}
