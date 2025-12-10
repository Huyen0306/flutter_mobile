import 'package:flutter/material.dart';

class BmiFeedbackScreen extends StatelessWidget {
  const BmiFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 5: BMI & Gửi phản hồi'),
      ),
      body: const Center(
        child: Text('Nội dung Bài tập 5'),
      ),
    );
  }
}
