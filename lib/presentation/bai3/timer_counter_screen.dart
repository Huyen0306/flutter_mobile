import 'package:flutter/material.dart';

class TimerCounterScreen extends StatelessWidget {
  const TimerCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập 3: Bộ đếm thời gian & Đếm số'),
      ),
      body: const Center(
        child: Text('Nội dung Bài tập 3'),
      ),
    );
  }
}
