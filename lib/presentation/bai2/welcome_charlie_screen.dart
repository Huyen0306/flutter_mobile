import 'package:flutter/material.dart';

class WelcomeCharlieScreen extends StatelessWidget {
  const WelcomeCharlieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 2: Welcome Charlie'),
      ),
      body: const Center(
        child: Text('Nội dung Bài tập 2'),
      ),
    );
  }
}
